;;;
;;; init.el
;;;

;;; load shell
;;;(exec-path-from-shell-initialize)

;;; loadpath:
(add-to-list 'load-path "~/.emacs.d/elisp/")

;;;theme
(load-theme 'tsdh-dark t)


;; Package Manegement
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
;; Coding system.
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;; 変換候補をミニバッファへ表示
(setq mozc-candidate-style 'echo-area) ;;これおすすめ

;; ハイライト高速化
(require 'hl-line)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
;; (cancel-timer global-hl-line-timer)

;; 対応する括弧を表示させる
(show-paren-mode 1)
;; 行が長くても自動的に折り返ししない
(auto-fill-mode 0)

(global-hl-line-mode 1)
(transient-mark-mode 1)
(line-number-mode 1)
(column-number-mode 1)
(ffap-bindings)

;;hide tooltip
;; menu-bar
(menu-bar-mode 0)

;; tool-bar
(tool-bar-mode 0)

;; メニューバーにファイルパスを表示する filepathファイル
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;;Font settings
(add-to-list 'default-frame-alist '(font . "ricty-11"))
(custom-set-faces
 '(variable-pitch ((t (:family "RictyDiscord"))))
 '(fixed-pitch ((t (:family "RictyDiscord"))))
 )

;; GCを減らして軽くする
;; 現在のマシンパワーではもっと大きくしてもよい
;; デフォルトの1000倍とする
(setq gc-cons-threshold (* 1000 gc-cons-threshold))

;; 行番号表示
(require 'linum)
(global-linum-mode 1)

;;Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;;Company
(require 'company)
(global-company-mode) ; 全バッファで有効にする 
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

;;Company Irony
(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony) ; backend追加

;;Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(when (require 'flycheck nil 'noerror)
  (custom-set-variables
   ;; エラーをポップアップで表示
   '(flycheck-display-errors-function
     (lambda (errors)
       (let ((messages (mapcar #'flycheck-error-message errors)))
         (popup-tip (mapconcat 'identity messages "\n")))))
   '(flycheck-display-errors-delay 0.5))
  (define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-previous-error)
  (add-hook 'c-mode-common-hook 'flycheck-mode))
;;Flycheck-irony
;;Flycheck-ironyでironyのパスから自動的にFlycheckのパスをしてくれる。
;;これはすごい　おすすめ
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
;; (eval-after-load "flycheck"
;;   '(progn
;;      (when (locate-library "flycheck-irony")
;;        (flycheck-irony-setup))))

;Matlab mode
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m$" . matlab-mode) auto-mode-alist)) 

;;Comment-dwin - M-;
(define-key global-map (kbd "C-;") 'comment-dwim)

;;Buffer Cycling
(require 'buffcycle)

;; Smooth scroll
;; (require 'smooth-scroll)
;; (smooth-scroll-mode t)
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(5 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed 'nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;; (setq scroll-step 1) ;; keyboard scroll one line at a time
;; (setq scroll-conservatively 0)
;; (setq scroll-margin 10)
(setq-default smooth-scroll-margin 0)
(setq scroll-step 1
      scroll-margin 1
      scroll-conservatively 100000)

;; 日本語のインクリメンタル検索
;; ref. http://qiita.com/catatsuy/items/c5fa34ead92d496b8a51
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)

;; YaTeX
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist (append
  '(("\\.tex$" . yatex-mode)
    ("\\.ltx$" . yatex-mode)
    ("\\.cls$" . yatex-mode)
    ("\\.sty$" . yatex-mode)
    ("\\.clo$" . yatex-mode)
    ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-kanji-code nil)

;;MarkDown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;Magit
(add-to-list 'load-path "~/.emacs.d/elisp/magit/lisp")
(require 'magit)
(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/elisp/magit/Documentation/"))

;;Cmake mode
(require 'cmake-mode); Add cmake listfile names to the mode list.
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))
;;(add-to-list 'company-backends 'company-cmake)

;;日本語スペルチェック
(require 'yspel)




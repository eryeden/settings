;;
;; init.el
;;

;;theme
(load-theme 'tsdh-light t)

(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
;; Coding system.
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Package Manegement
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

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
(require 'yasnippet);
(yas-global-mode 1);

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

;Matlab mode
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m$" . matlab-mode) auto-mode-alist)) 

;;Comment-dwin - M-;










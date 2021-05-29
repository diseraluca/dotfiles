;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Luca Di Sera"
      user-mail-address "disera.luca@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "MesloLGS NF" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; By default, double leader key is bound to "search file in project", which is
;; available on leader p f. As this is a function that is not call too often, it
;; is preferred to have double leader key on something that I use much more.
;; Specifically, being accustomed to spacemacs behaviour, it will be bounded to
;; M-x, which is by default bounded to leader :.
(map! :leader
     :desc "M-x"
     "SPC" 'counsel-M-x)

;; Spacemacs has a nice comment-uncomment function on leader ;. The default doom
;; bindings put this combination on eval expression. Now that the above freed
;; the leader : binding, eval expression will be moved there and leader ; will
;; be aligned with spacemacs' default, which is provided by g c c in doom emacs.
(map! :leader
      :desc "Eval expression"
      ":" 'pp-eval-expression)
(map! :leader
      :desc "Comment-uncomment"
      ";" 'evilnc-comment-operator)

;; Changing window is something that is done alot. Doom emacs places this functionality under the
;; triplet leader w n, where n is the window number ( requires the +number flag on the windows package ).
;; To allow an easier and faster access, window changing is moved to the simpler leader n, as in spacemacs.
;; The simpler access is provided for the first 9 windows, based on the utility functions from winum.el.
(map! :leader
      "1" 'winum-select-window-1
      "2" 'winum-select-window-2
      "3" 'winum-select-window-3
      "4" 'winum-select-window-4
      "5" 'winum-select-window-5
      "6" 'winum-select-window-6
      "7" 'winum-select-window-7
      "8" 'winum-select-window-8
      "9" 'winum-select-window-9)

;; Similar to the above, we would like an easier access to switching to the last buffer.
;; Doom emacs positions this as leader b l and it will be moved to leader TAB as in spacemacs.
(map! :leader
      :desc "Switch to last buffer"
      "TAB" 'evil-switch-to-windows-last-buffer)

;; Company

(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  )

;; CPP

(use-package! company-c-headers
  :defer t)

(after! ccls
  (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
  (set-lsp-priority! 'ccls 2)) ; optional as ccls is the default in Doom

(after! cc-mode
  (set-company-backend! 'c++-mode 'company-c-headers))

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;;(setq user-full-name "cletus adams"
;;      user-mail-address "cleadams.23@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-tokyo-night)
(setq doom-theme 'doom-oceanic-next)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;;************NAVIGATION*************
;;GGTAGS Config(From: https://tuhdo.github.io/c-ide.html#orgheadline4)
;;====================================================================

(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode 'python-mode)
              (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

;;Imenu facility: offers a way to find definitions in a buffer
(setq-local imenu-create-index-function #'ggtags-build-imenu-index)


;;**********CODE COMPLETION***************
;;Accomplished using company = "complete anythin". Company works with backends such
;;as Elisp, Clang, Semantic, Eclim, Yasnippet, etags, gtags, etc.
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;;enable code completion using Semantic
(require 'cc-mode)
(require 'semantic)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-mode 1)



;;ELEGANCE
;;************************************************
;;windmove
;;========
(require 'windmove)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
[](global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)
;; Maximize Emacs Window (Full Screen) at startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;;;Additions to keep errors quite
;;Error running timers
(setq lsp-enable-links nil)
(setq org-element-use-cache nil)


;;org-reveal
(setq org-reveal-root "file:///home/cletus/.emacs.d/reveal.js")


;;EMAIL CLIENT FOR EMACS
;;***************************************************
;;Notable website:  http://www.macs.hw.ac.uk/~rs46/posts/2014-01-13-mu4e-email-client.html
;; How to:
;; install appropriate packages and create .mbsyncrc file and setup as directed here:
;; https://ict4g.net/adolfo/notes/emacs/reading-imap-mail-with-emacs.html
;; run (in terminal): mbsync -a
;; run (in terminal): mu init --maildir=~/your-maildir-name --my-address=your-email-address
;; run (in terminal): mu index
;; now copy and paste the configs below to setup emacs for sending and receiving mails

;; configure emacs to send emails via smtp
(require 'smtpmail)
(setq user-full-name "cletus adams"
      user-mail-address "cletus.adams@snapit.group")

(setq mail-user-agent 'message-user-agent)
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-debug-info t
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

(setq auth-sources '("~/.authinfo.gpg"))
(setq auth-source-debug t)
(setq auth-source-do-cache nil)
(setq auth-source-passphrase-alist 'snapmail)

;; mu4e commands
;;https://www.djcbsoftware.nl/code/mu/mu4e/Keybindings.html
;; configure emacs to receive emails via mu4e
(after! mu4e
(setq mu4e-get-mail-command "mbsync gmail"
      ;; location of mail directory
      ;;mu4e-maildir (expand-file-name "~/Maildir")
      mu4e-root-maildir (expand-file-name "~/Maildir")
      ;;some definition to takes away errors, check later
      mu4e-headers-buffer-name "mu4e-headers*"
      ;; get emails and index every 1 minutes
      mu4e-update-interval 120
      ;; send emails with format=flowed
      mu4e-compose-format-flowed t
      ;; no need to run cleanup after indexing for gmail
      mu4e-index-cleanup nil
      mu4e-index-lazy-check t
      ;; more sensible date format
      mu4e-headers-date-format "%d.%m.%y"))


;; define load path for mu4e
(add-to-list 'load-path (expand-file-name "/usr/local/share/emacs/site-lisp/mu4e/"))
;;make sure emacs finds applications in /usr/local/bin
(setq exec-path (cons "/usr/local/bin" exec-path))



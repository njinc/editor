;;Time-stamp: <>

;;格式化整个文件
(global-set-key [(control i)] 'indent-whole-buffer)
(defun indent-whole-buffer ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil))


;;启用中文
(set-language-environment 'Chinese-GB)
(set-keyboard-coding-system 'euc-cn)
(set-clipboard-coding-system 'euc-cn)
(set-terminal-coding-system 'euc-cn)
(set-buffer-file-coding-system 'euc-cn)
(set-selection-coding-system 'euc-cn)
(modify-coding-system-alist 'process "*" 'euc-cn)
(setq default-process-coding-system
      '(euc-cn . euc-cn))


;;配色方案设定
(require 'color-theme)
(color-theme-initialize) ;;for windwos
(color-theme-dark-blue2)

;;设置字体
(set-default-font "-outline-Bitstream Vera Sans Mono-bold-r-normal-normal-13-97-96-96-c-*-iso8859-1")


;;换行自动缩进
(mapcar
  (lambda (mode)
    (let ((mode-hook (intern (concat (symbol-name mode) "-hook")))
          (mode-map (intern (concat (symbol-name mode) "-map"))))
      (add-hook mode-hook
                `(lambda nil
                   (local-set-key
                     (kbd "RET")
                     (or (lookup-key ,mode-map "\C-j")
                         (lookup-key global-map "\C-j")))))))
  '(c-mode c++-mode cperl-mode emacs-lisp-mode java-mode html-mode lisp-mode ruby-mode sh-mode))



;;换行对齐--对应于vim中的 Control-o
(global-set-key [(control o)] 'vi-open-next-line)
(defun vi-open-next-line (arg)
  "Move to the next line (like vi) and then opens a line."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (indent-according-to-mode))


;;括号自动完成
(setq skeleton-pair t)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)



;;自动完成
(global-set-key [(control space)] 'hippie-expand)
(global-set-key [(control return)] 'set-mark-command)
(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
         try-expand-dabbrev-all-buffers
         try-expand-dabbrev-from-kill
         try-complete-file-name-partially
         try-complete-file-name
         try-complete-lisp-symbol-partially
         try-complete-lisp-symbol
         try-expand-whole-kill))


;;整行移动
(global-set-key [(meta up)] 'move-line-up)
(global-set-key [(meta down)] 'move-line-down)
(defun move-line (&optional n)
  "Move current line N (1) lines up/down leaving point in place."
  (interactive "p")
  (when (null n)
    (setq n 1))
  (let ((col (current-column)))
    (beginning-of-line)
    (next-line 1)
    (transpose-lines n)
    (previous-line 1)
    (forward-char col)))
(defun move-line-up (n)
  "Moves current line N (1) lines up leaving point in place."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))
(defun move-line-down (n)
  "Moves current line N (1) lines down leaving point in place."
  (interactive "p")
  (move-line (if (null n) 1 n)))



;;自定义的按键绑定
(global-set-key [(meta n)]
                (lambda (&optional n) (interactive "p")
                  (scroll-up (or n 1))))
(global-set-key [(meta p)]
                (lambda (&optional n) (interactive "p")
                  (scroll-down (or n 1))))

(setq default-tab-width 4)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )


;;对javascript文件启用javascript-mode
(autoload 'javascript-mode "javascript" nil t)
(setq auto-mode-alist (cons '("\\.js\\'" . javascript-mode) auto-mode-alist))

;;sql-mode 下启用tsql-indent
(eval-after-load "sql"
                 '(load-library "sql-indent"))


;; find matching parenthese
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;;;; unshifted special chars
;;(defvar *unshifted-special-chars-layout*
;; '(("1" "!")								; from -> to
;;  ("2" "@")
;;  ("3" "#")
;;  ("4" "$")
;;  ("5" "%")
;;  ("6" "^")
;;  ("7" "&")
;;  ("8" "*")
;;  ("9" "(")
;;  ("0" ")")
;;  ("!" "1")
;;  ("@" "2")
;;  ("#" "3")
;;  ("$" "4")
;;  ("%" "5")
;;  ("^" "6")
;;  ("&" "7")
;;  ("*" "8")
;;  ("(" "9")
;;  (")" "0")))
;;(defun mb-str-to-unibyte-char (s)
;;"Translate first multibyte char in s to internal unibyte representation."
;;(multibyte-char-to-unibyte (string-to-char s)))
;;(defun remap-keyboard (mapping)
;;"Setup keyboard translate table using a list of pairwise key-mappings."
;;(mapcar
;; (lambda (mb-string-pair)
;;   (apply #'keyboard-translate
;;		  (mapcar #'mb-str-to-unibyte-char mb-string-pair)))
;; mapping))
;;(remap-keyboard *unshifted-special-chars-layout*)


;;Backups
(defconst use-backup-dir t)
(setq backup-directory-alist (quote ((".*" . "~/backup/temp/")))
      version-control t		   ; Use version numbers for backups
      kept-new-versions 16	   ; Number of newest versions to keep
      kept-old-versions 2	   ; Number of oldest versions to keep
      delete-old-versions t	   ; Ask to delete excess backup versions?
      backup-by-copying-when-linked t) ; Copy linked files, don't rename.


;;Copying the current line
(defadvice kill-ring-save (before slickcopy activate compile)
           "When called interactively with no active region, copy a single line instead."
           (interactive
             (if mark-active (list (region-beginning) (region-end))
               (list (line-beginning-position)
                     (line-beginning-position 2)))))
(defadvice kill-region (before slickcut activate compile)
           "When called interactively with no active region, kill a single line instead."
           (interactive
             (if mark-active (list (region-beginning) (region-end))
               (list (line-beginning-position)
                     (line-beginning-position 2)))))


;;记录修改时间
(add-hook 'write-file-hooks 'time-stamp)
(setq time-stamp-start "最后更新时间:[    ]+\\\\?")
(setq time-stamp-end "\n")
(setq time-stamp-format "%:y年%:m月%:d日")


;;个性化设置
(display-time)
(transient-mark-mode t)
(column-number-mode t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)



;;定义单词缩写为永久性
(setq-default abbrev-mode t)
;;(setq-abbrev-file "~/.abbrev_defs")
(setq save-abbrevs t)

;;使用python-mode.el
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;;Execute/Compile Current File
(defun run-current-file ()
  "Execute or compile the current file.
  For example, if the current buffer is the file x.pl,
  then it'll call “perl x.pl” in a shell.
  The file can be php, perl, python, bash, java.
  File suffix is used to determine what program to run."
  (interactive)
  (let (ext-map file-name file-ext prog-name cmd-str)
    (setq ext-map
          '(
            ("py" . "python")
            )
          )
    (setq file-name (buffer-file-name))
    (setq file-ext (file-name-extension file-name))
    (setq prog-name (cdr (assoc file-ext ext-map)))
    (setq cmd-str (concat prog-name " " file-name))
    (shell-command cmd-str)))

;;添加行号
(require 'linum)
(global-linum-mode t)

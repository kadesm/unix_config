; editing html code
;
; put following lines to your .emacs file
;(autoload 'html-mode "html"   "major mode for editing html code" t)
; and register extention ".html" to auto-mode-alist by adding
;("\\.html$" . html-mode)
;
; version 1.1 (Jan. 25, 1996)
;
(provide 'html-mode)
(defvar html-mode-map nil "Keymap for html mode")
(if html-mode-map
    nil
   (setq html-mode-map (make-sparse-keymap))
   (define-key html-mode-map "\C-c\C-f" 'html-close-block)
   (define-key html-mode-map "\C-c\C-e" 'html-close-tag-block)
   (define-key html-mode-map "\C-c\C-o" 'html-tag-block)
   (define-key html-mode-map "\C-c\C-u" 'html-goto-last-unclosed-tag-block)
)
(defun html-mode ()
  "major mode for editing html code"
  (interactive)
  (use-local-map html-mode-map)
  (setq mode-name "html")
  (setq major-mode 'html-mode)
  (setq paragraph-start "^[ \t]*$\\|^[\f\\\\%<]")
  (setq paragraph-separate paragraph-start)
)
(defun html-close-block ()
  "Creates an </...> to match <...> on the current line and
puts point on the blank line between them."
  (interactive "*")
  (let ((fail-point (point)))
    (end-of-line)
    (if (re-search-backward "<\\([^>\n ]*\\)[^>\n]*>"
                            (save-excursion (beginning-of-line) (point)) t)
        (let ((text (buffer-substring (match-beginning 1) (match-end 1)))
              (indentation (current-column)))
          (end-of-line)
          (delete-horizontal-space)
	  (if (or (string-equal text "ul")
		  (string-equal text "UL")
		  (string-equal text "ol")
		  (string-equal text "OL")
		  (string-equal text "dl")
		  (string-equal text "DL")
		  (string-equal text "address")
		  (string-equal text "ADDRESS")
		  (string-equal text "pre")
		  (string-equal text "PRE")
		  (string-equal text "head")
		  (string-equal text "HEAD")
		  (string-equal text "body")
		  (string-equal text "BODY")
		  )
	      (html-close-block-otherline text)
	      (html-close-block-inline text)
	    )
	  )
      (goto-char fail-point)
      (ding))))

(defun html-close-block-inline (text)
  (interactive "*")
  (insert "</" text ">")
  )
(defun html-close-block-otherline (text)
  (interactive "*")
  (insert "\n\n")
  (indent-to indentation)
  (insert "</" text ">")
  (forward-line -1)
)

;;; Like tex-insert-braces, but for LaTeX.
(defvar standard-html-block-names
  '("A" "B" "I" "EM" "UL" "DL" "OL" "DL" "ADDRESS" "PRE" "HEAD" "BODY" "HTML" 
    "a" "b" "i" "em" "ul" "dl" "ol" "dl" "address" "pre" "head" "body" "html" 
    )
  )
(defvar html-block-names nil
  "*User defined HTML block names.
Combined with `standard-html-block-names' for minibuffer completion.")

(defun html-tag-block (name)
  "Creates a matching pair of lines `<NAME>' and `</NAME>' at point.
Puts point on a blank line between them."
  (interactive
   (prog2
      (barf-if-buffer-read-only)
      (list
       (completing-read "HTML block name: "
			(mapcar 'list
                                (append standard-html-block-names
                                        html-block-names))))))
  (let ((col (current-column)))
    (insert (format "<%s>\n" name))
    (indent-to col)
    (save-excursion
      (insert ?\n)
      (indent-to col)
      (insert-string (format "</%s>" name))
      (if (eobp) (insert ?\n)))))


(defun html-goto-last-unclosed-tag-block ()
  "Move point to the last unclosed <...>.
Mark is left at original location."
  (interactive)
  (let ((spot))
    (save-excursion
      (condition-case nil
          (html-last-unended-begin)
        (error (error "Couldn't find unended <...>")))
      (setq spot (point)))
    (push-mark)
    (goto-char spot)))

(defun html-close-tag-block ()
  "Creates an </...> to match the last unclosed <...>."
  (interactive "*")
  (let ((new-line-needed (bolp))
	text indentation)
    (save-excursion
      (condition-case nil
          (html-last-unended-begin)
        (error (error "Couldn't find unended <...")))
      (setq indentation (current-column))
      (re-search-forward "<\\([^>\n/]*>\\)")
      (setq text (buffer-substring (match-beginning 1) (match-end 1))))
    (indent-to indentation)
    (insert "</" text)
    (if new-line-needed (insert ?\n))))

(defun html-last-unended-begin ()
  "Leave point at the beginning of the last `<...' that is unended."
  (while (and (re-search-backward "<[^Pp\\(BR\\)\\(LI\\)\\(li\\)\\(HR\\)\\(hr\\)!]")
	      (looking-at "</")
	      )
    (html-last-unended-begin)))




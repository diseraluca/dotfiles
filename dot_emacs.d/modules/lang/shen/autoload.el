;;; lang/shen/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +shen/new-inferior-shen ()
  (interactive)
  (progn (when (boundp 'inferior-shen-buffer)
           (progn (call-interactively 'switch-to-shen) (call-interactively 'rename-uniquely)))
         (call-interactively 'inferior-shen)))

;;;###autoload
(defmacro +shen-details-with-ensure-inferior-shen (f &rest args)
  `(defun ,(intern (format "+shen/%s" f)) ()
     (interactive)
     (progn (unless (and (boundp 'inferior-shen-buffer) (get-buffer inferior-shen-buffer))
              (progn (call-interactively #'inferior-shen)
                     (previous-window-any-frame)))
            (call-interactively #',f ,@args))))

;;;###autoload
(+shen-details-with-ensure-inferior-shen shen-eval-region)

;;;###autoload
(+shen-details-with-ensure-inferior-shen shen-eval-region-and-go)

;;;###autoload
(+shen-details-with-ensure-inferior-shen shen-eval-defun)

;;;###autoload
(+shen-details-with-ensure-inferior-shen shen-eval-defun-and-go)

;;;###autoload
(+shen-details-with-ensure-inferior-shen shen-eval-last-sexp)

;;;###autoload
(+shen-details-with-ensure-inferior-shen shen-load-file)

;;
;; My own setting
;;

;; =============================================================================
;; 새로운 프레임 생성시 크기 설정
;; =============================================================================
(setq initial-frame-alist '((width . 120) (height . 75))) ;; 첫번째 프래임의 크기를 설정
(setq default-frame-alist '((width . 80) (height . 40))) ;; 그 다음 프래임의 크기를 설정

;(setq load-path (nconc '("~/.emacs") load-path))	;; 개인 lisp 패키지가 위치 할 load-path 설정
;(setq load-path (nconc '("~/.emacs.d") load-path))	;; 개인 lisp 패키지가 위치 할 load-path 설정


(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(global-set-key [C-f1] 'show-file-name) ; Or any other key you want

; for cscope
(require 'xcscope)
(setq cscope-do-not-update-database t)

;; =============================================================================
;; person info
;; =============================================================================
(setq user-full-name "Doo-Hyun Jang")
(setq user-mail-address "dh.jang@gmail.com")

;; =============================================================================
;; 기본 색 지정
;; =============================================================================
(set-foreground-color "wheat")
(set-background-color "DarkSlateGray")

;; =============================================================================
;; 영역 색 지정
;; =============================================================================
(set-face-foreground 'region "white")
(set-face-background 'region "cadetblue")

;; =============================================================================
;; 한글 세벌식 최종
;; =============================================================================
(set-input-method "korean-hangul3f") ;; if you want 3 beolsik final...

;;모드라인에 현재 커서의 줄과 칼럼위치 시간 표시('mode line hacking'때문에 필요 없음)
(setq column-number-mode t)             ;;컬럼수를 모드라인에 표시할 경우 에디팅 속도가 느려진다

;; function to reload .emacs 2008.01.24
;; 출처 : http://hermian.tistory.com/195
(defun reload-dotemacs ()
  "Reload .emacs"
  (interactive)
  (load-file "~/.emacs.el"))

; for emacsclient
(server-start)

;; Switch fromm *.<impl> to *.<head> and vice versa
(defun switch-cc-to-h ()
  (interactive)
  (when (string-match "^\\(.*\\)\\.\\([^.]*\\)$" buffer-file-name)
	(let ((name (match-string 1 buffer-file-name))
		  (suffix (match-string 2 buffer-file-name)))
	  (cond ((string-match suffix "c\\|cc\\|C\\|cpp")
			 (cond ((file-exists-p (concat name ".h"))
					(find-file (concat name ".h"))
					)
				   ((file-exists-p (concat name ".hh"))
					(find-file (concat name ".hh"))
					)
				   ))
			((string-match suffix "h\\|hh")
			 (cond ((file-exists-p (concat name ".cc"))
					(find-file (concat name ".cc"))
					)
				   ((file-exists-p (concat name ".C"))
					(find-file (concat name ".C"))
					)
				   ((file-exists-p (concat name ".cpp"))
					(find-file (concat name ".cpp"))
					)
				   ((file-exists-p (concat name ".c"))
					(find-file (concat name ".c"))
					)))))))

;; ================================================================================
;; auto mode alist
;; ================================================================================
;;(setq-default auto-fill-function 'do-auto-fill)		;; auto-fill모드 설정
(autoload 'x-resource-generic-mode "generic-x" nil t)	;; generic-x 모드 설정
(setq auto-mode-alist
      (nconc '(("\\.ml[iylp]?\\'" . caml-mode)
               ("\\.sml\\'" . sml-mode)
               ("\\.grm\\'" . sml-mode)
               ("\\.ML\\'" . sml-mode)
               ("\\.htm\\'" . html-helper-mode)
               ("\\.html\\'" . html-helper-mode)
               ("\\.shtml\\'" . html-helper-mode)
               ("\\.thtml\\'" . html-helper-mode)
               ("\\.css\\'" . css-mode)
               ("\\.php\\'" . php-mode)
               ("\\.php3\\'" . php-mode)
               ("\\.gnus\\'" . emacs-lisp-mode)
               ("\\.abbrev_defs\\'" . emacs-lisp-mode)
               ("\\el\\'" . emacs-lisp-mode)
               ("\\.s?html\\'" . sgml-mode)
               ("\\.sgml\\'" . sgml-mode)
               ("\\.tex\\'" . latex-mode)
               ("\\.ks$\\'" . latex-mode)
               ("\\.cl\\'" . lisp-mode)
               ("\\.cgi\\'" . cperl-mode)
               ("\\.pl\\'" . cperl-mode)
               ("\\.pm\\'" . cperl-mode)
               ("\\.py\\'" . phthon-mode)
               ("\\.c\\'" . c-mode)
               ("\\.C\\'" . c-mode)
               ("\\.cc\\'" . c++-mode)
               ("\\.cpp\\'" . c++-mode)
               ("\\.h\\'" . c++-mode)
               ("\\.hh\\'" . c++-mode)
               ("\\.idl\\'" . c++-mode)
               ("\\.txi\\'" . Texinfo-mode)
               ("\\.java\\'" . java-mode)
               ("\\.prolog\\'" . prolog-mode)
               ("\\.pro\\'" . prolog-mode)
               ("\\.txt\\'" . text-mode))
             auto-mode-alist))

;; ================================================================================
;; C mode
;; ================================================================================
(add-hook 'c-mode-common-hook
          '(lambda()
            (c-set-style "k&r") ;;C 코딩 스타일 정의
))

(add-hook 'c++-mode-common-hook
          '(lambda()
            (c-set-style "k&r") ;;C 코딩 스타일 정의
))

;; revert buffer. 파일 내용이나 디렉토리 내용이 바뀌어서 Disk의 내용을 다시 불러올때
;; g : dired 모드에서 사용
;; M-x revert-buffer RET yes RET
;; C-x C-v RET		

(defun revert-all-buffers()
  "Refreshs all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
		 (buffer (car list)))
	(while buffer
	  (if (string-match "\\*" (buffer-name buffer)) 
	      (progn
	        (setq list (cdr list))
	        (setq buffer (car list)))
		(progn
		  (set-buffer buffer)
		  (revert-buffer t t t)
		  (setq list (cdr list))
		  (setq buffer (car list))))))
  (message "Refreshing open files"))

;; ================================================================================
;; show paren mode. 괄호등을 사용할때 마지막에 사용된 괄호에 대응하는 괄호를 찾음
;; ================================================================================
(show-paren-mode 1)


(setq enable-recursive-minibuffers t)


;; ================================================================================
;; ;;indent with just spaces 들여쓰기 설정
;; ================================================================================
;;(setq-default indent-tabs-mode nil)   ;; nil 이 아니면 들여쓰기 명령이 탭문자를 입력한다.(버퍼지역변수)
(setq-default indent-tabs-mode t)		;; nil 이 아니면 들여쓰기 명령이 탭문자를 입력한다.(버퍼지역변수)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 26 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(setq default-tab-width 4)              ;; 탭간 간격(버퍼지역변수)
;; automatically indenting yanked text if in programming-modes
;; 붙여넣기 하면서 자동 들여쓰기 함수
(defadvice yank (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode
                           c-mode c++-mode
                           tcl-mode sql-mode
                           perl-mode cperl-mode
                           java-mode jde-mode
                           LaTeX-mode TeX-mode))
	  (let ((transient-mark-mode nil))
		(indent-region (region-beginning) (region-end) nil))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "NanumGothicCoding" :foundry "nil" :slant normal :weight normal :height 141 :width normal)))))

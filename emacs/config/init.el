(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line


;;自动安装函数
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar myPackages
  '(imenu-anywhere
    ac-etags
    counsel-etags
    which-key
    undo-tree
    neotree
    swiper
    ivy
    magit
    counsel-projectile
    projectile
    ))
(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

(global-undo-tree-mode)

(which-key-setup-side-window-bottom)
;;(which-key-setup-side-window-right)
;;(which-key-setup-side-window-right-bottom)
(which-key-mode 1) 
(global-auto-complete-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;cedet
;; (require 'semantic/ia)
 (semantic-mode 1)
;;(add-hook 'c-mode-common-hook 'auto-complete-mode)
 (global-semanticdb-minor-mode t)	 ;;缓存解析过的源代码的结果，以便以后可以使用
 (global-semantic-idle-scheduler-mode t)	 ;;emacs空闲时分析源代码
 (global-semantic-idle-summary-mode t)	 ;;对当前位点处符号，显示分析出来的结果的摘要
;; (global-semantic-idle-completions-mode t);;代码补全功能，可以使用命令进行选择
 (global-semantic-decoration-mode t)	 ;;顾名思义，使用不同的显示风格来显示分析出来的不同结果
 (global-semantic-highlight-func-mode t)	 ;;高亮函数或者标签的声明行
 (global-semantic-stickyfunc-mode t)	 ;;在文本的最上层显示函数的声明信息
 (global-semantic-mru-bookmark-mode t)	 ;;保存使用过的所有tag，mru是最多最近使用的意思
;; ;;f1补全快捷键
;;(global-set-key [f2] 'semantic-ia-complete-symbol-menu)
;; ;;ctrl-回车，绑定自动补全
;; (add-hook 'semantic-after-idle-scheduler-reparse-hook
;; 	  (lambda ()
;; 	    (message "parse done!")
;; 	    (local-set-key (kbd "C-<retrun>")
;; 			   'semantic-complete-analyze-inline-idle)))
;; ;;跳转到函数/变量定义的地方
;; (global-set-key [f6] 'semantic-ia-fast-jump)
;; ;;为了跳回去，要使用函数semantic-mrub-switch-tags，但老是报出【Semantic Bookmark ring is currently empty】错误。原因是函数semantic-ia-fast-jump调用了函数push-mark，而函数push-mark里面没有做push bookmark的操作，所以要修改函数push-mark，把bookmark放入semantic-mru-bookmark-ring里。放入后再执行semantic-mrub-switch-tags就不会出错了
;; (defadvice push-mark (around semantic-mru-bookmark activate)
;;   "Push a mark at LOCATION with NOMSG and ACTIVATE passed to `push-mark'.
;; If `semantic-mru-bookmark-mode' is active, also push a tag onto
;; the mru bookmark stack."
;;   (semantic-mrub-push semantic-mru-bookmark-ring
;;                       (point)
;;                       'mark)
;;   ad-do-it)

;; ;;跳转后再跳回原来的地方
;; (global-set-key [f5]
;;       (lambda()
;;     (interactive)
;;     (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
;;         (error "Semantic Bookmark ring is currently empty"))
;;     (let* ((ring (oref semantic-mru-bookmark-ring ring))
;;            (alist (semantic-mrub-ring-to-assoc-list ring))
;;            (first (cdr (car alist))))
;;     (if (semantic-equivalent-tag-p (oref first tag)
;;                        (semantic-current-tag))
;;         (setq first (cdr (car (cdr alist)))))
;;     (semantic-mrub-switch-tags first))))

;; ;当代码需要补齐的时候，让补齐代码的显示方式是在tooltip里
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(gdb-use-colon-colon-notation t)
;;  '(package-selected-packages
;;    (quote
;;     (phi-rectangle highlight-symbol ggtags auto-complete)))
;;  '(semantic-complete-inline-analyzer-idle-displayor-class (quote semantic-displayor-tooltip)))



;;王垠的配置
;;不在鼠标点击的位置插入黏贴内容
(setq mouse-yank-at-point t)
(setq kill-ring-max 200)
;;设置fill-column为60
(setq default-fill-column 60)
;;不用tab来indent代码
(setq-default indent-tabs-mode nil)
(setq default-table-width 8)
(setq tab-stop-list ())
;;(loop for x down from 40 to 1 do
;;      (setq tab-stop-list (cons (* x 4) tab-stop-list)))
;;设置sentence-end可以识别中文标点
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
;;可以递归使用minibuffer
(setq enable-recursive-minibuffers t)
;;方式页面滚动的时候跳动
(setq scroll-margin 3
      scroll-conservatively 10000)
;;标题栏提示buffer名字
(setq frame-title-format "emacs@%b")
;;支持直接打开浏览图片
(auto-image-file-mode)
;;语法加亮
(global-font-lock-mode t)
(setq default-major-mode 'text-mode)
;;备份文件版本控制
;;(setq version-control t)
;;(setq kept-new-versions 3)
;;(setq delete-old-versions t)
;;(setq kept-old-versions 2)
;;(setq dired-kept-versions 1)
;;简单设置auto-mode-alist
(mapcar
 (function (lambda (setting)
	     (setq auto-mode-alist
		   (cons setting auto-mode-alist))))
 '(("\\.xml$".  sgml-mode)
   ("\\\.bash" . sh-mode)
   ("\\.rdf$".  sgml-mode)
   ("\\.session" . emacs-lisp-mode)
   ("\\.l$" . c-mode)
   ("\\.css$" . css-mode)
   ("\\.cfm$" . html-mode)
   ("gnus" . emacs-lisp-mode)
      ("\\.idl$" . idl-mode)))
;;可以递归拷贝和删除目录
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)


;;个人信息
(setq user-full-name "shouchengcheng")
(setq user-mail-address "shouchengcheng@163.com")


;;显示时间
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
;;不要滚动栏
(scroll-bar-mode nil)
;;让M-w能复制内容到剪切板
(setq x-select-enable-clipboard t)
;;当指针到一个括号时，自动显示所匹配的另一个括号
(show-paren-mode 1)
;;显示行号
;;(global-linum-mode)
;;不显示工具条
(tool-bar-mode 0)
;;不显示菜单
(menu-bar-mode 0)
;;高亮当前行
(global-hl-line-mode 0)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes nil)
 '(package-selected-packages
   (quote
    (counsel-projectile imenu-anywhere ac-etags counsel-etags counsel which-key undo-tree neotree swiper ivy))))

;;ivy config
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;;(setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
;;(global-set-key (kbd "C-c C-r") 'ivy-resume)
;;(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;;(global-set-key (kbd "<f1> f") 'counsel-describe-function)
;;(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;;(global-set-key (kbd "<f1> l") 'counsel-find-library)
;;(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;;(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
;;(global-set-key (kbd "C-c k") 'counsel-ag)
;;(global-set-key (kbd "C-x l") 'counsel-locate)
;;(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;;(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;;使用emacs自带的代码跳转
;; M-.跳转
;; f1返回跳转地址
(global-set-key (kbd "<f1>") 'pop-tag-mark)
;;imenu-anywhere
(global-set-key (kbd "<f2>") 'imenu-anywhere)
(global-set-key [f10] 'neotree-toggle)
(global-set-key (kbd "M-.") 'xref-find-definitions-other-window)

(projectile-global-mode)
(setq projectile-enable-caching t)
(global-set-key [f6] 'counsel-projectile-find-file)
;;(global-set-key [f7] 'projectile-find-tag)
(global-set-key (kbd "M-.") 'projectile-find-tag)
;; org-mode support dot
;; dot :cmd dot :file name :export results
(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t)))


;;; Compiled snippets and support files for `js2-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'js2-mode
		     '(("class" "var ${1:name} = new Class({\n  initialize: function($2) {\n    $0\n  }\n});" "Class" nil nil nil nil nil nil)
		       ("def" "define(['underscore',\n        'jquery',\n        'backbone'\n	], function(_,\n	            $,\n	            Backbone) {\n\n	$0\n\n});" "def" nil nil
			((yas-indnet-line 'fixed))
			nil nil nil)))


;;; Do not edit! File generated at Sat Sep  6 10:54:24 2014

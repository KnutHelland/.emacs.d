;;; Compiled snippets and support files for `js2-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'js2-mode
		     '(("class" "var ${1:name} = new Class({\n  initialize: function($2) {\n    $0\n  }\n});" "Class" nil nil nil nil nil nil)
		       ("def" "define(['underscore',\n        'jquery',\n        'backbone'],\n	function(_,\n	         $,\n	         Backbone) {\n\n	$0\n\n});" "def" nil nil
			((yas-indent-line 'fixed))
			nil nil nil)
		       ("dx" "define(['underscore',\n        'jquery',\n        'backbone',\n        'dx'],\n	function(_,\n	         $,\n	         Backbone,\n	         dx) {\n\n	return ${1:Backbone.}.extend({\n\n		initialize: function() {\n			$0\n		}\n\n	});\n});\n" "dx js file" nil nil
			((yas-indent-line 'fixed))
			nil nil nil)
		       ("dxview" "define(['underscore',\n        'jquery',\n        'backbone',\n        'dx'],\n	function(_,\n	         $,\n	         Backbone,\n	         dx) {\n\n	return Backbone.View.extend({\n\n		initialize: function() {\n			$0\n		},\n\n		render: function() {\n			return this;\n		}\n	});\n});" "dxview" nil nil
			((yas-indent-line 'fixed))
			nil nil nil)
		       ("log" "console.log($0);" "console.log" nil nil nil nil nil nil)
		       ("render" "render: function() {\n	$0\n	return this;\n}" "render" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Sat Sep  6 12:10:32 2014

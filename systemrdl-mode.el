;;; systemrdl-mode.el --- sample major mode for editing SystemRDL.

;; Copyright (C) 2019, by Paul Donahue

;; Author: Paul Donahue <systemrdl-mode@pauldonahue.com>
;; Version: 1.0.0
;; Created: 21 Aug 2019
;; Keywords: systemrdl languages

;; This file is not part of GNU Emacs.

;;; License:

;;    This program is free software: you can redistribute it and/or modify
;;    it under the terms of the GNU General Public License as published by
;;    the Free Software Foundation, either version 3 of the License, or
;;    (at your option) any later version.
;;
;;    This program is distributed in the hope that it will be useful,
;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;    GNU General Public License for more details.
;;
;;    You should have received a copy of the GNU General Public License
;;    along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Performs syntax highlighting and indentation for SystemRDL 2.0

;; Due to the hierarchical structure of bracketed groups of
;; semicolon-terminated statements, this inherits most of its functionality
;; from c-mode.

;;; Code:

(defconst rdl-keywords-regexp
  (eval-when-compile
    (regexp-opt '("abstract" "addrmap" "alias" "all" "bothedge" "component"
                  "componentwidth" "constraint" "default" "encode" "external"
                  "field" "inside" "internal" "level" "mem" "negedge"
                  "nonsticky" "number" "posedge" "property" "reg" "regfile"
                  "signal" "struct" "this" "type") 'words)))

(defconst rdl-types-regexp
  (eval-when-compile
    (regexp-opt '("boolean" "string" "bit" "longint" "unsigned" "accesstype"
                  "addressingtype" "onreadtype" "onwritetype" "ref"
                  "enum") 'words)))

(defconst rdl-constants-regexp
  (eval-when-compile
    (regexp-opt '("rw" "wr" "r" "w" "rw1" "w1" "na" "rclr" "rset" "ruser"
                  "woset" "woclr" "wot" "wzs" "wzc" "wzt" "wclr" "wset"
                  "wuser" "true" "false" "compact" "regalign"
                  "fullalign") 'words)))

(defconst rdl-preprocessor-regexp
  (eval-when-compile
    (regexp-opt '("\`define" "\`else" "\`elsif" "\`endif" "\`if" "\`ifdef"
                  "\`ifndef" "\`include" "\`line" "\`undef"))))

(defconst rdl-events-regexp
  (eval-when-compile
    (regexp-opt '("") 'words)))

(defconst rdl-properties-regexp
  (eval-when-compile
    (regexp-opt '("sw" "hw" "name" "desc" "intr" "enable" "mask" "haltenable"
                  "sticky" "stickybit" "precedence" "encode"
                  "paritycheck") 'words)))

(setq systemrdl-font-lock-keywords
      (let* ()
        `(
          (, rdl-types-regexp . font-lock-type-face)
          (, rdl-constants-regexp . font-lock-constant-face)
          (, rdl-events-regexp . font-lock-builtin-face)
          (, rdl-properties-regexp . font-lock-function-name-face)
          (, rdl-keywords-regexp . font-lock-keyword-face)
          (, rdl-preprocessor-regexp . font-lock-preprocessor-face)
          )))

(defun systemrdl-indent-function ()
  (save-excursion
    (beginning-of-line)
    (indent-line-to (* 2 (car (syntax-ppss))))))

;;;###autoload
(define-derived-mode systemrdl-mode c-mode "SystemRDL mode"
  "Major mode for editing SystemRDL"

  (set (make-local-variable 'indent-line-function) #'systemrdl-indent-function)

  ;; Don't treat the quote in things like 3'b000 as starting a
  ;; string.  It's just punctuation.
  (modify-syntax-entry ?\' ".")

  ;; Underscores are word characters.
  (modify-syntax-entry ?_  "w")

  ;; Escaping keywords makes them not keywords (like a field named \reg)
  (modify-syntax-entry ?\\ "w")

  ;; Treat embedded perl as a comment.  Not ideal but unless you
  ;; run mmm-mode, it's not going to highlight properly anyway.
  (modify-syntax-entry ?< ". 1")
  (modify-syntax-entry ?% ". 23")
  (modify-syntax-entry ?> ". 4")

  ;; Make M-x comment-region and uncomment-region work properly.
  (setq-local comment-start "//")
  (setq-local comment-end "")
  
  (setq font-lock-defaults '((systemrdl-font-lock-keywords))))

(provide 'systemrdl-mode)

;;; systemrdl-mode.el ends here

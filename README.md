#systemrdl-mode

An emacs mode for SystemRDL 2.0 with syntax highlighting and indentation.

The SystemRDL 2.0 standard is freely available from
[Accellera](https://www.accellera.org/downloads/standards/systemrdl).

## Installation

###To install
1. Copy systemrdl-mode.el to somewhere in your emacs load-path.
1. Add the following to your .emacs file:
```
(require 'systemrdl-mode)
(setq auto-mode-alist (cons '("\\.rdl$" . systemrdl-mode) auto-mode-alist))
```

###Newbie installation
If you don't understand the directions above, try this:

1. copy the file to some directory such as ~/emacs
1. edit ~/.emacs to contain:
```
(add-to-list 'load-path "~/emacs") ; or whatever directory you chose
(require 'systemrdl-mode)
(setq auto-mode-alist (cons '("\\.rdl$" . systemrdl-mode) auto-mode-alist))
```

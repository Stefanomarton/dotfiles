# Vim preview for Markdown, Tex, Groff
A plugin to open groff, latex and markdown live pdf preview

---

### Requirements

* **groff** with the `groff_ms` macro
* **pandoc** for markdown and latex
* **zathura** pdf viewer

---

### Installation

```
Plug 'Stefanomarton/texgroff.vim'
```

### Keybindings

#### Default keybindings
| Leader | Key | Action |
|:------:|:---:|:------:|
| 	/		 |  p  | Open live PDF Preview |
| 	/		 |  c  | Compile groff(.ms)/latex(.tex)/markdown(.md) |

#### Custom keybindings
```
noremap <leader>p :call Preview()<CR><CR><CR>
noremap <leader>c :call Compile()<CR><CR>
```

### To do
- Autorefreshing using fswatch

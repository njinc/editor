"习惯参数设置
syn on  "打开语法加亮
colors desert "设置配色方案
set guifont=Bitstream_Vera_Sans_Mono:h13:cANSI "设置字体

set autoindent
set number	    "打开数字行标
set softtabstop=4   "tab建缩减设为4空格
set shiftwidth=4    "语法缩进设为4空格
set nobackup    "关闭自动备份
"设置F12为python运行
map <F12> :!python % 

"设置F5插入时间，F6插入日期
map <F5> :r !time/T<CR><ESC>kJA
map <F6> :r !date/T<CR><ESC>kJA

set tabstop=4
set smarttab
set cursorline
set expandtab
set bsdir=last  "默认打开上次的文件夹
set laststatus=2

"set listchars=tab:>-,trail:-

let g:calendar_diary="D:\\Documents\\diary\\vim"    "日志存放位置

set completeopt=longest,menu
filetype plugin on  "启用文件类型的插件
filetype indent on  "启用自动缩进

" Encoding settings
if has("multi_byte")
    " Set fileencoding priority
    if getfsize(expand("%")) > 0
	set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    else
	set fileencodings=cp936,big5,euc-jp,euc-kr,latin1
    endif

    " CJK environment detection and corresponding setting
    if v:lang =~ "^zh_CN"
	set encoding=cp936
	set termencoding=cp936
	set fileencoding=cp936
    elseif v:lang =~ "^zh_TW"
	" cp950, big5 or euc-tw
	" Are they equal to each other?
	set encoding=big5
	set termencoding=big5
	set fileencoding=big5
    elseif v:lang =~ "^ko"
	" Copied from someone's dotfile, untested
	set encoding=euc-kr
	set termencoding=euc-kr
	set fileencoding=euc-kr
    elseif v:lang =~ "^ja_JP"
	" Copied from someone's dotfile, unteste
	set encoding=euc-jp
	set termencoding=euc-jp
	set fileencoding=euc-jp
    endif
    " Detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
	set encoding=utf-8
	set termencoding=utf-8
	set fileencoding=utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif

"Nice statusbar
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\ " buffer number
set statusline+=%f\ " file name
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=[
if v:version >= 600
    set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
    set statusline+=%{&encoding}, " encoding
endif
set statusline+=%{&fileformat}] " file format
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
    set statusline+=\ %{VimBuddy()} " vim buddy
endif
set statusline+=%= " right align
set statusline+=%2*0x%-8B\ " current char
set statusline+=0x%-8B\ " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset


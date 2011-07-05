" A ref source for pman.
" Version: 0.0.1
" Author : soh335 <sugarbabe335@gmail.com>
" License: Creative Commons Attribution 2.1 Japan License
"          <http://creativecommons.org/licenses/by/2.1/jp/deed.en>

let s:save_cpo = &cpo
set cpo&vim

scriptencoding utf-8



" config. {{{1
if !exists('g:ref_pman_cmd')  " {{{2
  let g:ref_man_cmd = executable('pman') ? 'pman' : ''
endif


let s:source = {'name': 'pman'}  " {{{1

function! s:source.available()  " {{{2
  return !empty(self.option('cmd'))
endfunction



function! s:source.get_body(query)  " {{{2
  let [query, sec] = s:parse(a:query)
  let q = sec =~ '\d' ? [sec, query] : [query]

  let res = ref#system(ref#to_list(self.option('cmd')) + q)

  if !res.result
    let body = res.stdout
    if &termencoding != '' && &encoding != '' && &termencoding !=# &encoding
      let encoded = iconv(body, &termencoding, &encoding)
      if encoded != ''
        let body = encoded
      endif
    endif

    let body = substitute(body, '.\b', '', 'g')
    let body = substitute(body, '\e\[[0-9;]*m', '', 'g')
    let body = substitute(body, '‘', '`', 'g')
    let body = substitute(body, '’', "'", 'g')
    let body = substitute(body, '[−‐]', '-', 'g')
    let body = substitute(body, '·', 'o', 'g')

    return body
  endif
  let list = self.complete(a:query)
  if !empty(list)
    return list
  endif
  throw matchstr(res.stderr, '^\_s*\zs.\{-}\ze\_s*$')
endfunction



function! s:source.opened(query)  " {{{2
  call s:syntax()
endfunction



function! s:source.get_keyword()  " {{{2
  let isk = &l:isk
  setlocal isk& isk+=- isk+=. isk+=:
  let kwd = ref#get_text_on_cursor('[[:alnum:]_.:+-]\+\%((\d)\)\?')  
  let &l:isk = isk
  return kwd
endfunction



function! s:source.complete(query)  " {{{2
  let [query, sec] = s:parse(a:query)
  let sec -= 0  " to number

  return filter(copy(self.cache(sec, self)),
  \             'v:val =~# "^\\V" . query')
endfunction



function! s:source.normalize(query)  " {{{2
  let name = substitute(a:query, '::', '.', 'g')
  let [query, sec] = s:parse(name)
  return query . (sec == '' ? '' : '(' . sec . ')')
endfunction



function! s:source.call(name)  " {{{2
  let list = []
  if a:name is 0
    for n in range(1, 9)
      let list += self.cache(n, self)
    endfor

  else
    let manpath = self.option('path')
    let pat = '.*/\zs.*\ze\.\d\w*\%(\.\w\+\)\?$'
    for path in split(matchstr(manpath, '^.\{-}\ze\_s*$'), ':')
      let dir = path . '/man' . a:name
      if isdirectory(dir)
        let list += map(split(glob(dir . '*/*'), "\n"),
        \                  'matchstr(v:val, pat)')
      endif
    endfor
  endif

  return ref#uniq(list)
endfunction



function! s:source.option(opt)  " {{{2
  if a:opt ==# 'path'
    return substitute(ref#system(ref#to_list(self.option('cmd')) + ["-w"]).stdout, "\n", "", "")
  endif
  return g:ref_man_{a:opt}
endfunction



function! s:parse(query)  " {{{2
  let l = matchlist(a:query, '\([^[:space:]()]\+\)\s*(\(\d\))$')
  if !empty(l)
    return l[1 : 2]
  endif
  let l = matchlist(a:query, '\(\d\)\s\+\(\S*\)')
  if !empty(l)
    return [l[2], l[1]]
  endif
  return [a:query, '']
endfunction



function! s:syntax()  " {{{2
  if exists('b:current_syntax') && b:current_syntax == 'ref-phpmanual'
    return
  endif

  syntax clear

  unlet! b:current_syntax
  syntax include @refPhpmanualPHP syntax/php.vim
  syntax match refPhpmanualFunc '\h\w*\ze()'

  syn region phpRegion matchgroup=Delimiter start="<?php" end="?>" contains=@phpClTop

  highlight default link refPhpmanualFunc phpFunctions

  let b:current_syntax = 'ref-phpmanual'
endfunction




function! ref#pman#define()  " {{{2
  return copy(s:source)
endfunction

if s:source.available()  " {{{1
  call ref#register_detection('php', 'pman', 'append')
endif



let &cpo = s:save_cpo
unlet s:save_cpo


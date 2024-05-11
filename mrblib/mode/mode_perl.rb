module Mrbmacs
  class PerlMode < Mode
    def initialize
      super
      @name = 'perl'
      @lexer = 'perl'
      @keyword_list = "NULL __FILE__ __LINE__ __PACKAGE__ __DATA__ __END__ AUTOLOAD \
      BEGIN CORE DESTROY END EQ GE GT INIT LE LT NE CHECK abs accept \
      alarm and atan2 bind binmode bless caller chdir chmod chomp chop \
      chown chr chroot close closedir cmp connect continue cos crypt \
      dbmclose dbmopen defined delete die do dump each else elsif endgrent \
      endhostent endnetent endprotoent endpwent endservent eof eq eval \
      exec exists exit exp fcntl fileno flock for foreach fork format \
      formline ge getc getgrent getgrgid getgrnam gethostbyaddr gethostbyname \
      gethostent getlogin getnetbyaddr getnetbyname getnetent getpeername \
      getpgrp getppid getpriority getprotobyname getprotobynumber getprotoent \
      getpwent getpwnam getpwuid getservbyname getservbyport getservent \
      getsockname getsockopt glob gmtime goto grep gt hex if index \
      int ioctl join keys kill last lc lcfirst le length link listen \
      local localtime lock log lstat lt map mkdir msgctl msgget msgrcv \
      msgsnd my ne next no not oct open opendir or ord our pack package \
      pipe pop pos print printf prototype push quotemeta qu \
      rand read readdir readline readlink readpipe recv redo \
      ref rename require reset return reverse rewinddir rindex rmdir \
      scalar seek seekdir select semctl semget semop send setgrent \
      sethostent setnetent setpgrp setpriority setprotoent setpwent \
      setservent setsockopt shift shmctl shmget shmread shmwrite shutdown \
      sin sleep socket socketpair sort splice split sprintf sqrt srand \
      stat study sub substr symlink syscall sysopen sysread sysseek \
      system syswrite tell telldir tie tied time times truncate \
      uc ucfirst umask undef unless unlink unpack unshift untie until \
      use utime values vec wait waitpid wantarray warn while write \
      xor \
      given when default say state UNITCHECK"
      @start_of_comment = '# '

      @style[Scintilla::SCE_PL_DEFAULT] = :color_default
      @style[Scintilla::SCE_PL_ERROR] = :color_warning
      @style[Scintilla::SCE_PL_COMMENTLINE] = :color_comment
      @style[Scintilla::SCE_PL_POD] = :color_comment
      @style[Scintilla::SCE_PL_NUMBER] = :color_default
      @style[Scintilla::SCE_PL_WORD] = :color_keyword
      @style[Scintilla::SCE_PL_STRING] = :color_string
      @style[Scintilla::SCE_PL_CHARACTER] = :color_string
      @style[Scintilla::SCE_PL_PUNCTUATION] = :color_default
      @style[Scintilla::SCE_PL_PREPROCESSOR] = :color_preprocessor
      @style[Scintilla::SCE_PL_OPERATOR] = :color_default
      @style[Scintilla::SCE_PL_IDENTIFIER] = :color_default
      @style[Scintilla::SCE_PL_SCALAR] = :color_default
      @style[Scintilla::SCE_PL_ARRAY] = :color_default
      @style[Scintilla::SCE_PL_HASH] = :color_default
      @style[Scintilla::SCE_PL_SYMBOLTABLE] = :color_default
      @style[Scintilla::SCE_PL_VARIABLE_INDEXER] = :color_default
      @style[Scintilla::SCE_PL_REGEX] = :color_default
      @style[Scintilla::SCE_PL_REGSUBST] = :color_default
      @style[Scintilla::SCE_PL_LONGQUOTE] = :color_default
      @style[Scintilla::SCE_PL_BACKTICKS] = :color_default
      @style[Scintilla::SCE_PL_DATASECTION] = :color_default
      @style[Scintilla::SCE_PL_HERE_DELIM] = :color_default
      @style[Scintilla::SCE_PL_HERE_Q] = :color_default
      @style[Scintilla::SCE_PL_HERE_QQ] = :color_default
      @style[Scintilla::SCE_PL_HERE_QX] = :color_default
      @style[Scintilla::SCE_PL_STRING_Q] = :color_default
      @style[Scintilla::SCE_PL_STRING_QQ] = :color_default
      @style[Scintilla::SCE_PL_STRING_QX] = :color_default
      @style[Scintilla::SCE_PL_STRING_QR] = :color_default
      @style[Scintilla::SCE_PL_STRING_QW] = :color_default
      @style[Scintilla::SCE_PL_POD_VERB] = :color_default
      @style[Scintilla::SCE_PL_SUB_PROTOTYPE] = :color_default
      @style[Scintilla::SCE_PL_FORMAT_IDENT] = :color_default
      @style[Scintilla::SCE_PL_FORMAT] = :color_default
      @style[Scintilla::SCE_PL_STRING_VAR] = :color_default
      @style[Scintilla::SCE_PL_XLAT] = :color_default
      @style[Scintilla::SCE_PL_REGEX_VAR] = :color_default
      @style[Scintilla::SCE_PL_REGSUBST_VAR] = :color_default
      @style[Scintilla::SCE_PL_BACKTICKS_VAR] = :color_default
      @style[Scintilla::SCE_PL_HERE_QQ_VAR] = :color_default
      @style[Scintilla::SCE_PL_HERE_QX_VAR] = :color_default
      @style[Scintilla::SCE_PL_STRING_QQ_VAR] = :color_default
      @style[Scintilla::SCE_PL_STRING_QX_VAR] = :color_default
      @style[Scintilla::SCE_PL_STRING_QR_VAR] = :color_default
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end

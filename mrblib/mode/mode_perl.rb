module Mrbmacs
  class PerlMode < Mode
    def initialize
      super.initialize
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
      @style = [
        :color_foreground, # define SCE_PL_DEFAULT 0
        :color_warning, # define SCE_PL_ERROR 1
        :color_comment, # define SCE_PL_COMMENTLINE 2
        :color_comment, # define SCE_PL_POD 3
        :color_foreground, # define SCE_PL_NUMBER 4
        :color_keyword, # define SCE_PL_WORD 5
        :color_string, # define SCE_PL_STRING 6
        :color_string, # define SCE_PL_CHARACTER 7
        :color_foreground, # define SCE_PL_PUNCTUATION 8
        :color_preprocessor, # define SCE_PL_PREPROCESSOR 9
        :color_foreground, # define SCE_PL_OPERATOR 10
        :color_foreground, # define SCE_PL_IDENTIFIER 11
        :color_foreground, # define SCE_PL_SCALAR 12
        :color_foreground, # #define SCE_PL_ARRAY 13
        :color_foreground, # #define SCE_PL_HASH 14
        :color_foreground, # #define SCE_PL_SYMBOLTABLE 15
        :color_foreground, # #define SCE_PL_VARIABLE_INDEXER 16
        :color_foreground, # #define SCE_PL_REGEX 17
        :color_foreground, # #define SCE_PL_REGSUBST 18
        :color_foreground, # #define SCE_PL_LONGQUOTE 19
        :color_foreground, # #define SCE_PL_BACKTICKS 20
        :color_foreground, # #define SCE_PL_DATASECTION 21
        :color_foreground, # #define SCE_PL_HERE_DELIM 22
        :color_foreground, # #define SCE_PL_HERE_Q 23
        :color_foreground, # #define SCE_PL_HERE_QQ 24
        :color_foreground, # #define SCE_PL_HERE_QX 25
        :color_foreground, # #define SCE_PL_STRING_Q 26
        :color_foreground, # #define SCE_PL_STRING_QQ 27
        :color_foreground, # #define SCE_PL_STRING_QX 28
        :color_foreground, # #define SCE_PL_STRING_QR 29
        :color_foreground, # #define SCE_PL_STRING_QW 30
        :color_foreground, # #define SCE_PL_POD_VERB 31
        :color_foreground, # #define SCE_PL_SUB_PROTOTYPE 40
        :color_foreground, # #define SCE_PL_FORMAT_IDENT 41
        :color_foreground, # #define SCE_PL_FORMAT 42
        :color_foreground, # #define SCE_PL_STRING_VAR 43
        :color_foreground, # #define SCE_PL_XLAT 44
        :color_foreground, # #define SCE_PL_REGEX_VAR 54
        :color_foreground, # #define SCE_PL_REGSUBST_VAR 55
        :color_foreground, # #define SCE_PL_BACKTICKS_VAR 57
        :color_foreground, # #define SCE_PL_HERE_QQ_VAR 61
        :color_foreground, # #define SCE_PL_HERE_QX_VAR 62
        :color_foreground, # #define SCE_PL_STRING_QQ_VAR 64
        :color_foreground, # #define SCE_PL_STRING_QX_VAR 65
        :color_foreground  # #define SCE_PL_STRING_QR_VAR 66
      ]
    end

    def set_style(view_win, theme)
      super
      view_win.sci_set_property('fold.compact', '1')
    end
  end
end

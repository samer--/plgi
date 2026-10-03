dnl Process this file with autoconf to produce a configure script.

AC_INIT
AC_CONFIG_SRCDIR([src/plgi.h])
AC_PREREQ([2.72])
AC_CONFIG_HEADERS([src/config.h])

AC_SUBST(CC)
AC_SUBST(GI_CFLAGS)
AC_SUBST(GI_LIBS)
AC_SUBST(GI_DATADIR)

AC_PROG_INSTALL
AC_PROG_CC([])

AC_CHECK_SIZEOF(long)

PKG_CHECK_MODULES(GI,
    glib-2.0
    gio-2.0
    gobject-2.0
    gobject-introspection-1.0
)

GI_DATADIR=$($PKG_CONFIG --variable=gidatadir gobject-introspection-1.0)

AC_CONFIG_FILES([Makefile src/Makefile test/Makefile])
AC_OUTPUT

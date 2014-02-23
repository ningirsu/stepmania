#include "global.h"

#if defined(_WINDOWS)
#  if defined(CRASH_HANDLER)
#    define _WIN32_WINDOWS 0x0410 // include Win98 stuff
#    include "windows.h"
#    include "archutils/Win32/Crash.h"
#  endif
#elif defined(MACOSX)
#  include "archutils/Darwin/Crash.h"
using CrashHandler::IsDebuggerPresent;
using CrashHandler::DebugBreak;
#else
#  include <unistd.h>
#endif

// Get around crash handling definition.
#if defined(ANDROID)
#include "archutils/Android/CrashHandler.h"
#endif

#if defined(CRASH_HANDLER) && (defined(UNIX) || defined(MACOSX))
#if defined(ANDROID)
#include "archutils/Android/CrashHandler.h"
#else
#include "archutils/Unix/CrashHandler.h"
#endif
#endif

void NORETURN sm_crash( const char *reason )
{
#if ( defined(_WINDOWS) && defined(CRASH_HANDLER) ) || defined(MACOSX) || defined(_XDBG)
	/* If we're being debugged, throw a debug break so it'll suspend the process. */
	if( IsDebuggerPresent() )
	{
		DebugBreak();
		while(1); /* don't return */
	}
#endif

// PARTIAL crash handler.
#if defined(CRASH_HANDLER) || defined(ANDROID)
	CrashHandler::ForceCrash( reason );
#else
	*(char*)0=0;

	/* This isn't actually reached.  We just do this to convince the compiler that the
	 * function really doesn't return. */
	while(1);
#endif

#if defined(_WINDOWS)
	/* Do something after the above, so the call/return isn't optimized to a jmp; that
	 * way, this function will appear in backtrace stack traces. */
#if defined(_MSC_VER)
	_asm nop;
#elif defined(__GNUC__) // MinGW or similar
	asm("nop");
#endif
#else
	_exit( 1 );
#endif
}

/*
 * (c) 2004-2014 Glenn Maynard, Renaud Lepage
 * All rights reserved.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, and/or sell copies of the Software, and to permit persons to
 * whom the Software is furnished to do so, provided that the above
 * copyright notice(s) and this permission notice appear in all copies of
 * the Software and that both the above copyright notice(s) and this
 * permission notice appear in supporting documentation.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF
 * THIRD PARTY RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS
 * INCLUDED IN THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT
 * OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
 * OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
 * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 */

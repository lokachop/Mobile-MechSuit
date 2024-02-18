gcc  -static -shared -m64 -fPIC -O2 -o compiled/tracelib.so tracelib.c

copy /y /b "compiled\tracelib.so" "..\ffi\tracelib.so"
datawarehouse = [
        '-DLINUX',
        '-D_GLIBCXX_USE_CXX11_ABI=0',
        '-DUSE_CPP11=1',
        '-DNO_WARN_ON_COMMAND_UNUSED_RESULT',
        # The following should only be used until we update boost_1_41_0
        '-D_LIBCPP_ENABLE_CXX17_REMOVED_AUTO_PTR',
        '-m32',
        ]
includes = [
        '-I/Users/ivey/tools/omniture/bin/p/frag_api/1.0/bin/include',
        '-I/Users/ivey/tools/omniture/include',
        '-I.',
        '-isystem',
        '/usr/local/opt/openssl/include',
        '-isystem',
        '/Users/ivey/tools/mysql',
        '-isystem',
        '/Users/ivey/tools/boost_1_41_0',
        '-isystem',
        '/Users/ivey/dev/dw-all/external/fmt-4.1.0',
        '-I/Users/ivey/dev/dw-all/apps/breakdown/src',
        '-I/Users/ivey/dev/dw-all/common/zdw',
        '-I/Users/ivey/dev/dw-all/common/lobby/src',
        '-I/Users/ivey/dev/dw-all/common/workbench',
        '-I/Users/ivey/dev/dw-all/common/datawarehouse/src',
        '-I/Users/ivey/dev/dw-all/libraries/exceptions',
        '-I/Users/ivey/dev/dw-all/libraries',
        ]
flags = [
        '-x',
        'cpp'
        '--std=gnu++17',
        '-D_FILE_OFFSET_BITS=64',
        '-O0',
        '-g',
        '-pthread',
        '-Wall',
        '-Wextra',
        '-Werror',
        # The -M will print an include graph and return successful compile
        # '-M',
        '-fPIC',
        ]

def FlagsForFile(filename, **kwargs):
  return {'flags': datawarehouse + includes + flags, 'do_cache': True}

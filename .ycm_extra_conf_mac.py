import os

flags = [
    '-x',
    'c++',
    '-isystem',
    '/usr/local/Cellar/llvm/6.0.0/include/c++/v1',
    '-isystem',
    '/usr/local/include',
    '-isystem',
    '/usr/local/Cellar/llvm/6.0.0/lib/clang/6.0.0/include',
    '-isystem',
    '/usr/include',
    '-isystem',
    '/System/Library/Frameworks'
    '-isystem',
    '/Library/Frameworks',
]

SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c']

def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in ['.h', '.hxx', '.hpp', '.hh']

def FindCorrespondingSourceFile(filename):
    if IsHeaderFile(filename):
        basename = os.path.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                return replacement_file
    return filename

def FlagsForFile(filename, **kwargs):
    # If the file is a header, try to find the corresponding source file and
    # retrieve its flags from the compilation database if using one. This is
    # necessary since compilation databases don't have entries for header files.
    # In addition, use this source file as the translation unit. This makes it
    # possible to jump from a declaration in the header file to its definition in
    # the corresponding source file.
    filename = FindCorrespondingSourceFile(filename)

    return {
        'flags': flags,
        'override_filename': filename
    }

TEMPLATE = app

QT += core network

include($$PWD/config/config.pri)
include($$PWD/qttp/qttp.pri)

HEADERS += \
    $$PWD/src/*.h

SOURCES += \
    $$PWD/main.cpp \
    $$PWD/src/*.cpp

LIBS += -luv -lhttp_parser -lnode_native

#LIBS += -mongoclient -L$$PWD/lib/mongo-cxx-driver/build/darwin/normal
#INCLUDEPATH += \
#    $$PWD/lib/mongo-cxx-driver/src \
#    $$PWD/lib/mongo-cxx-driver/build/darwin/normal \
#    /usr/local/opt/boost155/include
#LDFLAGS:  -L/usr/local/opt/boost155/lib
#CPPFLAGS: -I/usr/local/opt/boost155/include

INCLUDEPATH += \
    $$PWD/lib/http-parser \
    $$PWD/lib/libuv/ \
    $$PWD/lib/libuv/include \
    $$PWD/lib/http/include \
    $$PWD/lib/http/include/native \
    $$PWD/qttp

QMAKE_CXXFLAGS += -g -O0 -lm -lpthread -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64

unix: {
}

macx: {
    LIBS += -framework CoreFoundation -framework CoreServices
    CONFIG += c++14
    QMAKE_CXXFLAGS += -std=gnu++0x -stdlib=libc++
}

unix:!macx {
    CONFIG += c++0x
    # This supports GCC 4.7
    QMAKE_CXXFLAGS += -std=c++0x
}

win {
	# We need some TLC later in this section
}

CONFIG(debug, debug|release) {
    LIBS += -L$$PWD/out/Debug
    DEPENDPATH += $$PWD/out/Debug
    DESTDIR = $$PWD/out/qtdebug
    OBJECTS_DIR = $$PWD/out/qtdebug
    MOC_DIR = $$PWD/out/qtdebug
    RCC_DIR = $$PWD/out/qtdebug
    UI_DIR = $$PWD/out/qtdebug
    unix:!macx {
        # For some reason Ubuntu 12 LTS doesn't jive with only the static lib
        OBJECTS += $$PWD/out/Debug/obj.target/http_parser/lib/http-parser/http_parser.o
    }
} else {
    LIBS += -L$$PWD/out/Release
    DEPENDPATH += $$PWD/out/Release
    DESTDIR = $$PWD/out/qtrelease
    OBJECTS_DIR = $$PWD/out/qtrelease
    MOC_DIR = $$PWD/out/qtrelease
    RCC_DIR = $$PWD/out/qtrelease
    UI_DIR = $$PWD/out/qtrelease
    unix:!macx {
        OBJECTS += $$PWD/out/Release/obj.target/http_parser/lib/http-parser/http_parser.o
    }
}

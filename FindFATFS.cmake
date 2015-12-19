IF(NOT STM32Cube_DIR)
    SET(STM32Cube_DIR "/opt/STM32Cube_FW_F1_V1.2.0")
    MESSAGE(STATUS "No STM32Cube_DIR specified, using default: " ${STM32Cube_DIR})
ENDIF()

SET(FATFS_COMMON_SOURCES
    diskio.c
    ff.c
    ff_gen_drv.c
)
SET(FATFS_DIRVER_SOURCES
    sd_diskio.c
    sdram_diskio.c
    sram_diskio.c
    usbh_diskio.c
)
SET(FATFS_OPTION_SOURCES
    cc932.c
    cc936.c
    cc949.c
    cc950.c
    ccsbcs.c
    syscall.c
    unicode.c
)

SET(FATFS_COMMON_HEADERS
    diskio.h
    ff.h
    ff_gen_drv.h
    ffconf_template.h
    integer.h
)

SET(FATFS_DRIVER_HEADERS
    sd_diskio.h
    sdram_diskio.h
    sram_diskio.h
    usbh_diskio.h
)

FIND_PATH(FATFS_COMMON_INCLUDE_DIR ${FATFS_COMMON_HEADERS}
    HINTS ${STM32Cube_DIR}/Middlewares/Third_Party/FatFs/src
    CMAKE_FIND_ROOT_PATH_BOTH
)

FIND_PATH(FATFS_DRIVER_INCLUDE_DIR ${FATFS_DRIVER_HEADERS}
    HINTS ${STM32Cube_DIR}/Middlewares/Third_Party/FatFs/src/drivers/
    CMAKE_FIND_ROOT_PATH_BOTH
)

SET(FATFS_INCLUDE_DIRS
    ${FATFS_COMMON_INCLUDE_DIR}
    ${FATFS_DRIVER_INCLUDE_DIR}
)

FOREACH(SRC ${FATFS_COMMON_SOURCES})
    SET(SRC_FILE SRC_FILE-NOTFOUND)
    FIND_FILE(SRC_FILE ${SRC}
        HINTS ${STM32Cube_DIR}/Middlewares/Third_Party/FatFs/src/
        CMAKE_FIND_ROOT_PATH_BOTH
    )
    LIST(APPEND FATFS_SOURCES ${SRC_FILE})
ENDFOREACH()

FOREACH(SRC ${FATFS_DIRVER_SOURCES})
    SET(SRC_FILE SRC_FILE-NOTFOUND)
    FIND_FILE(SRC_FILE ${SRC}
        HINTS ${STM32Cube_DIR}/Middlewares/Third_Party/FatFs/src/drivers/
        CMAKE_FIND_ROOT_PATH_BOTH
    )
    LIST(APPEND FATFS_SOURCES ${SRC_FILE})
ENDFOREACH()

FOREACH(SRC ${FATFS_OPTION_SOURCES})
    SET(SRC_FILE SRC_FILE-NOTFOUND)
    FIND_FILE(SRC_FILE ${SRC}
        HINTS ${STM32Cube_DIR}/Middlewares/Third_Party/FatFs/src/option/
        CMAKE_FIND_ROOT_PATH_BOTH
    )
    LIST(APPEND FATFS_SOURCES ${SRC_FILE})
ENDFOREACH()
#message(STATUS "fatfs include " ${FATFS_INCLUDE_DIRS})
#message(STATUS "fatfs sources " ${FATFS_SOURCES})

INCLUDE(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(FATFS DEFAULT_MSG FATFS_INCLUDE_DIRS FATFS_SOURCES)

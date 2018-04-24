LIST (APPEND check_PROGRAMS
  unpack_pack_fuzzer.cc
)

FOREACH (source_file ${check_PROGRAMS})
    GET_FILENAME_COMPONENT (source_file_we ${source_file} NAME_WE)
    ADD_EXECUTABLE (
        ${source_file_we}
        ${source_file}
    )
    TARGET_LINK_LIBRARIES (${source_file_we}
        msgpackc
        runner
    )
    ADD_TEST (${source_file_we} ${source_file_we})
    IF ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        SET_PROPERTY (TARGET ${source_file_we} APPEND_STRING PROPERTY COMPILE_FLAGS " -Wall -Wextra")
    ENDIF ()
    IF ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        SET_PROPERTY (TARGET ${source_file_we} APPEND_STRING PROPERTY COMPILE_FLAGS " -Wno-mismatched-tags")
    ENDIF ()

    IF ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        IF (CMAKE_CXX_FLAGS MATCHES "/W[0-4] /WX")
            STRING(REGEX REPLACE "/W[0-4]" "/W3 /WX" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
        ELSE ()
            SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W3")
        ENDIF ()
      ENDIF ()

   ADD_TEST (

     )

ENDFOREACH ()

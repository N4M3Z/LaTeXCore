CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

PROJECT(LaTeXProject NONE)
# CMakeLists files in this project can refer to the root source directory of the project as ${<ProjectName>_SOURCE_DIR}
# and to the root binary directory of the project as ${<ProjectName>_BINARY_DIR}.

INCLUDE(UseLATEX.cmake)

SET(LATEX_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/Output      )
SET(ENV(TEXMF)        ${PROJECT_SOURCE_DIR}/Dependencies)

FILE(GLOB_RECURSE TeXFiles   RELATIVE ${PROJECT_SOURCE_DIR} Contents/*.tex)
FILE(GLOB_RECURSE StyleFiles RELATIVE ${PROJECT_SOURCE_DIR} Styles/*.cls)
FILE(GLOB_RECURSE ClassFiles RELATIVE ${PROJECT_SOURCE_DIR} Styles/*.sty)

MESSAGE(STATUS "Project source dir: ${PROJECT_SOURCE_DIR}")
MESSAGE(STATUS "CMake source dir:   ${CMAKE_CURRENT_SOURCE_DIR}")

MESSAGE(STATUS "Project binary dir: ${PROJECT_BINARY_DIR}")
MESSAGE(STATUS "CMake binary dir:   ${CMAKE_CURRENT_BINARY_DIR}")

ADD_LATEX_DOCUMENT(
    Master.tex
    INPUTS ${TeXFiles}
    IMAGE_DIRS Images
    #BIBFILES References.bib
    #USE_INDEX
    #USE_GLOSSARY
    #FILTER_OUTPUT
    DEFAULT_PDF
    )

#
# Author: ansonn.wang
# 2015/07/20
#

AR 			:= ar            
SED			:= sed          
AWK			:= awk
MV 			:= mv
RM 			:= rm -f
ECHO 		:= echo


# C编译器选项
CC      	:= gcc
CFLAGS 		:= -c -g  -W -Wall
 
# C++编译器选项
CXX     	:= g++
CXXFLAGS 	:= -c -g -W -Wall

#
INCLUDES 	:= -I./src
LIBDIRS 	:= -L./lib

CLDFLAGS    :=  -lelf -ldwarf
CXXLDFLAGS  :=  -lelf -ldwarf 
  
#
SRC_DIR   	:= ./src 
SFIX     	:=  .c .C .cpp  .cc .CPP  .c++  .cp  .cxx
VPATH 		:= ${SRC_DIR}
 
#          
BIN 		:= ./bin
SOURCES 	:= $(foreach x,${SRC_DIR},\
           					$(wildcard  \
             				$(addprefix  ${x}/*,${SFIX}) ) )
OBJS 		:= $(addsuffix .o ,$(basename $(notdir ${SOURCES}) ) )    
DEPENDS 	:= $(addsuffix .d ,$(basename  ${SOURCES} ) )  

#
PROGRAM   := mem_analyser
 

.PHONY : all check  clean  install
all :  ${PROGRAM}  install
 
LDCXX := $(strip $(filter-out  %.c , ${SOURCES} ) )
ifdef LDCXX
    CC 			:= ${CXX}
    CFLAGS 		:= ${CXXFLAGS}
    CPP 		:= ${CXXPP}
    CPPFLAGS 	:= ${CXXPPFLAGS}
endif
 
#
${PROGRAM} :  ${DEPENDS}  ${OBJS} 
ifeq ($(strip $(filter-out  %.c  , ${SOURCES} ) ),)
	${CC}  ${LIBDIRS}  ${CLDFLAGS}    ${OBJS} -o $@    
else
	@${ECHO}  LIBDIRS : ${LIBDIRS}
	@${ECHO}  CXXLDFLAGS : ${CXXLDFLAGS}
	$(CXX) ${LIBDIRS}  ${CXXLDFLAGS}  ${OBJS} -o $@     
endif
 
#
%.o : %.c
	$(CC)      ${DCPPFLAGS}    ${CFLAGS}      ${INCLUDES}   $<
%.o : %.C
	$(CXX)     ${DCPPFLAGS}    ${CXXFLAGS}    ${INCLUDES}   $<
%.o : %.cc
	${CXX}     ${DCPPFLAGS}    ${CXXFLAGS}    ${INCLUDES}   $<
%.o : %.cpp
	${CXX}     ${DCPPFLAGS}    ${CXXFLAGS}    ${INCLUDES}   $<
%.o : %.CPP
	${CXX}     ${DCPPFLAGS}    ${CXXFLAGS}    ${INCLUDES}   $<
%.o : %.c++
	${CXX}     ${DCPPFLAGS}    ${CXXFLAGS}    ${INCLUDES}   $<
%.o : %.cp
	${CXX}     ${DCPPFLAGS}    ${CXXFLAGS}    ${INCLUDES}   $<
%.o : %.cxx
	${CXX}     ${DCPPFLAGS}    ${CXXFLAGS}    ${INCLUDES}   $<
 
#
%.d : %.c
	@${CC}     -M   -MD    ${INCLUDES} $<
%.d : %.C
	@${CXX}    -MM  -MD    ${INCLUDES} $<
%.d : %.cc
	@${CXX}    -MM  -MD    ${INCLUDES} $<
%.d : %.cpp
	@${CXX}    -MM  -MD    ${INCLUDES} $<
%.d : %.CPP
	@${CXX}    -MM  -MD    ${INCLUDES} $<
%.d : %.c++
	@${CXX}    -MM  -MD    ${INCLUDES} $<
%.d : %.cp
	@${CXX}    -MM  -MD    ${INCLUDES} $<
%.d : %.cxx
	@${CXX}    -MM  -MD    ${INCLUDES} $<
 
check :
	@${ECHO}  MAKEFILES : ${MAKEFILES}
	@${ECHO}  MAKECMDGOALS : ${MAKECMDGOALS}
	@${ECHO}  SRC_DIR : ${SRC_DIR}
	@${ECHO}  SFIX : ${SFIX}
	@${ECHO}  VPATH : ${VPATH}
	@${ECHO}  BIN : ${BIN}
	@${ECHO}  SOURCES : ${SOURCES}
	@${ECHO}  OBJS : ${OBJS}
	@${ECHO}  DEPENDS : ${DEPENDS}
	@${ECHO}  PROGRAM : ${PROGRAM}
	@${ECHO}  CC :  ${CC}
	@${ECHO}  CFLAGS : ${CFLAGS}
	@${ECHO}  CPP : ${CPP}
	@${ECHO}  CPPFLAGS : ${CPPFLAGS}
	@${ECHO}  CXX :  ${CXX}
	@${ECHO}  CXXFLAGS : ${CXXFLAGS}
	@${ECHO}  CXXPP : ${CXXPP}
	@${ECHO}  CXXPPFLAGS : ${CXXPPFLAGS}       
	@${ECHO}  INCLUDES : ${INCLUDES}
	@${ECHO}  LIBDIRS : ${LIBDIRS}
	@${ECHO}  CLDFLAGS : ${CLDFLAGS}
	@${ECHO}  CXXLDFLAGS : ${CXXLDFLAGS}
	@${ECHO}  DCPPFLAGS : ${DCPPFLAGS}
	uname    -a

clean :
	-${RM} ${BIN}/${PROGRAM}
	-${RM} ${BIN}/*.o
	-${RM} ${BIN}/*.d
	-${RM} *.o
	-${RM} *.d

install :
	-${MV} ${PROGRAM} ${BIN}
	-${MV}  *.o ${BIN}
	-${MV}  *.d ${BIN}
#


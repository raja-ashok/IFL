SRC_DIR=src
BIN_DIR=bin
OBJ_DIR=obj
STATIC_LIB=$(BIN_DIR)/libifl.a
TARGET=$(STATIC_LIB)
DEPENDENCY_DIR=dependency
CJSON=cJSON
CJSON_SRC_DIR=$(DEPENDENCY_DIR)/$(CJSON)
CJSON_DIR=$(BIN_DIR)/$(CJSON)
CJSON_LIB=$(CJSON_DIR)/libcjson.a
DEPENDENCY=$(CJSON_LIB)

SRCS=$(wildcard $(SRC_DIR)/*.c)
OBJS=$(addprefix $(OBJ_DIR)/,$(SRCS:.c=.o))

CC = gcc
AR = ar
RM = rm

ifeq ($(NOSAN),1)
	SAN_CFLAGS=
else
	SAN_CFLAGS= -fsanitize=address
endif

CFLAGS = -g -ggdb -O0 -Wall -Werror $(SAN_CFLAGS) -fstack-protector-all
LFLAGS = 

INC = -I ./src -I ./include -I $(CJSON_DIR)
CFLAGS += $(INC)

.PHONY: all clean init_setup

all: init_setup $(TARGET)

$(CJSON_LIB):$(CJSON_SRC_DIR)
	@echo "Building cJSON..."
	@mkdir -p $(CJSON_DIR)
	@cd $(CJSON_DIR) && cmake ../../$(CJSON_SRC_DIR) > /dev/null

init_setup: $(DEPENDENCY)
	@mkdir -p $(OBJ_DIR)/$(SRC_DIR)
	@mkdir -p $(BIN_DIR)

$(OBJ_DIR)/%.o:%.c
	$(CC) $(CFLAGS) -o $@ -c $^

$(STATIC_LIB): $(OBJS)
	$(AR) r $@ $^

clean:
	@$(RM) -rf $(OBJS)
	@$(RM) -rf $(TARGET)
	@$(RM) -rf $(OBJ_DIR) $(BIN_DIR)

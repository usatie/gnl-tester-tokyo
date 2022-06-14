# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: susami <susami@student.42tokyo.jp>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/04/15 09:49:28 by susami            #+#    #+#              #
#    Updated: 2022/06/14 14:41:45 by susami           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GNL_DIR			=	./..
M_SRCS			=	$(GNL_DIR)/get_next_line.c\
					$(GNL_DIR)/get_next_line_utils.c
M_OBJS			=	$(M_SRCS:$(GNL_DIR)/%.c=%.o)
M_HEADER		=	$(GNL_DIR)/get_next_line.h
B_SRCS			=	$(GNL_DIR)/get_next_line_bonus.c\
					$(GNL_DIR)/get_next_line_utils_bonus.c
B_OBJS			=	$(B_SRCS:$(GNL_DIR)/%.c=%.o)
B_HEADER		=	$(GNL_DIR)/get_next_line_bonus.h

NAME			=	run-test
NAME_ECHO		=	gnl-echo
LIBASSERT_DIR	=	./libs/libassert/
LIBASSERT		=	$(LIBASSERT_DIR)libassert.a
LIBS			= 	./libs/*/*.a
CC				=	gcc
INCS			=	./includes
CFLAGS			=	-Wall -Wextra -Werror -fsanitize=address -I $(INCS) -I $(GNL_DIR)

ERROR_LOG		=	error.log
SRCS			=	srcs/main.c

.PHONY: m1 m42 m10M m1G echo mandatory all clean fclean re norm
all:
	make -C $(LIBASSERT_DIR)
	make m
	make b

m:
	make -C $(LIBASSERT_DIR)
	make m1
	make m42
	make m10M
	make mecho
	@#This test is slow so please run it alone
	@#make m1G

b:
	make -C $(LIBASSERT_DIR)
	make b1
	make b42
	make b10M
	make becho
	@#This test is slow so please run it alone
	@#make b1G

m1: SIZE = 1
m1: $(LIBASSERT) mandatory
m42: SIZE = 42
m42: $(LIBASSERT) mandatory
m10M: SIZE = 10000000
m10M: $(LIBASSERT) mandatory
m1G: SIZE = 1000000000
m1G: $(LIBASSERT) mandatory

mandatory: $(SRCS) $(M_SRCS)
	@$(RM) $(ERROR_LOG).$(SIZE)
	$(CC) $(M_SRCS) -c $(CFLAGS) -D BUFFER_SIZE=$(SIZE)
	$(CC) $(SRCS) $(LIBASSERT) $(M_OBJS) -o $(NAME) $(CFLAGS) -D BUFFER_SIZE=$(SIZE)
	./run-test <files/alternate_line_nl_with_nl 2>>$(ERROR_LOG).$(SIZE)
	@find . -name $(ERROR_LOG).$(SIZE) -size 0 -exec rm {} \;
	@[ ! -f $(ERROR_LOG).$(SIZE) ] &&\
		printf "\e[32m\n\n------------------------------------------------------------\
		\n[MANDATORY PARTS(BUFFER_SIZE=$(SIZE))] All tests passed successfully! Congratulations :D\n\e[m" ||\
		printf "\e[31m\n\n------------------------------------------------------------\
		\nSome tests failed. Please see $(ERROR_LOG).$(SIZE) for more detailed information.\n\e[m"

b1: SIZE = 1
b1: $(LIBASSERT) bonus
b42: SIZE = 42
b42: $(LIBASSERT) bonus
b10M: SIZE = 10000000
b10M: $(LIBASSERT) bonus
b1G: SIZE = 1000000000
b1G: $(LIBASSERT) bonus

bonus: $(SRCS) $(B_SRCS)
	@$(RM) $(ERROR_LOG).$(SIZE)
	$(CC) $(B_SRCS) -c $(CFLAGS) -D BUFFER_SIZE=$(SIZE)
	$(CC) $(SRCS) $(LIBASSERT) $(B_OBJS) -o $(NAME) $(CFLAGS) -D BUFFER_SIZE=$(SIZE)
	./run-test <files/alternate_line_nl_with_nl 2>>$(ERROR_LOG).$(SIZE)
	@find . -name $(ERROR_LOG).$(SIZE) -size 0 -exec rm {} \;
	@[ ! -f $(ERROR_LOG).$(SIZE) ] &&\
		printf "\e[32m\n\n------------------------------------------------------------\
		\n[BONUS PARTS(BUFFER_SIZE=$(SIZE))] All tests passed successfully! Congratulations :D\n\e[m" ||\
		printf "\e[31m\n\n------------------------------------------------------------\
		\nSome tests failed. Please see $(ERROR_LOG).$(SIZE) for more detailed information.\n\e[m"

ECHO_SRCS	=	srcs/gnl_echo.c

mecho: $(ECHO_SRCS) $(M_OBJS)
	$(CC) $(ECHO_SRCS) $(M_OBJS) -o $(NAME_ECHO) $(CFLAGS)
	./gnl_echo_test.sh

becho: $(ECHO_SRCS) $(B_OBJS)
	$(CC) $(ECHO_SRCS) $(B_OBJS) -o $(NAME_ECHO) $(CFLAGS)
	./gnl_echo_test.sh

$(LIBASSERT):
	$(MAKE) -C $(LIBASSERT_DIR)

clean:
	$(RM) $(ERROR_LOG).* $(M_OBJS) $(B_OBJS)
	$(MAKE) -C ./libs/libassert clean

fclean: clean
	$(RM) $(NAME) $(NAME_ECHO)
	$(MAKE) -C ./libs/libassert fclean

re: fclean all

norm:
	@echo "------------------------------Checking norminette------------------------------"
	norminette $(GNL_DIR)/*.c $(GNL_DIR)/*.h | grep -v "OK!" || printf "\e[32mnorminette OK :D\e[m"

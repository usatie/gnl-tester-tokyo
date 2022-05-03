# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: susami <susami@student.42tokyo.jp>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/04/15 09:49:28 by susami            #+#    #+#              #
#    Updated: 2022/05/03 21:14:34 by susami           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GNL_DIR			=	./..
GNL_SRCS		=	$(GNL_DIR)/get_next_line.c\
					$(GNL_DIR)/get_next_line_utils.c
GNL_OBJS		=	$(GNL_SRCS:$(GNL_DIR)/%.c=%.o)
GNL_HEADER		=	$(GNL_DIR)/get_next_line.h

NAME			=	run-test
LIBASSERT_DIR	=	./libs/libassert/
LIBASSERT		=	$(LIBASSERT_DIR)libassert.a
LIBS			= 	./libs/*/*.a
CC				=	gcc
INCS			=	./includes
CFLAGS			=	-Wall -Wextra -Werror -fsanitize=address -I $(INCS) -I $(GNL_DIR)

ERROR_LOG		=	error.log
SRCS			=	srcs/main.c

.PHONY: m1 m42 m10M m1G mandatory all clean fclean re norm
all:
	make -C $(LIBASSERT_DIR)
	make m1
	make m42
	make m10M
	@#This test is slow so please run it alone
	@#make m1G

m1: SIZE = 1
m1: $(LIBASSERT) mandatory
m42: SIZE = 42
m42: $(LIBASSERT) mandatory
m10M: SIZE = 10000000
m10M: $(LIBASSERT) mandatory
m1G: SIZE = 1000000000
m1G: $(LIBASSERT) mandatory

mandatory: $(SRCS) $(GNL_SRCS)
	@$(RM) $(ERROR_LOG).$(SIZE)
	$(CC) $(GNL_SRCS) -c $(CFLAGS) -D BUFFER_SIZE=$(SIZE)
	$(CC) $(SRCS) $(LIBASSERT) $(GNL_OBJS) -o $(NAME) $(CFLAGS) -D BUFFER_SIZE=$(SIZE)
	./run-test <files/alternate_line_nl_with_nl 2>>$(ERROR_LOG).$(SIZE)
	@find . -name $(ERROR_LOG).$(SIZE) -size 0 -exec rm {} \;
	@[ ! -f $(ERROR_LOG).$(SIZE) ] &&\
		printf "\e[32m\n\n------------------------------------------------------------\
		\n[MANDATORY PARTS(BUFFER_SIZE=$(SIZE))] All tests passed successfully! Congratulations :D\n\e[m" ||\
		printf "\e[31m\n\n------------------------------------------------------------\
		\nSome tests failed. Please see $(ERROR_LOG).$(SIZE) for more detailed information.\n\e[m"

$(LIBASSERT):
	$(MAKE) -C $(LIBASSERT_DIR)

clean:
	$(RM) $(ERROR_LOG).* $(GNL_OBJS)
	$(MAKE) -C ./libs/libassert clean

fclean: clean
	$(RM) $(NAME)
	$(MAKE) -C ./libs/libassert fclean

re: fclean all

norm:
	@echo "------------------------------Checking norminette------------------------------"
	norminette $(GNL_DIR)/*.c $(GNL_DIR)/*.h | grep -v "OK!" || printf "\e[32mnorminette OK :D\e[m"

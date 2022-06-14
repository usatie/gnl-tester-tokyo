/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_stdin.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: susami <susami@student.42tokyo.jp>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/06/14 14:22:30 by susami            #+#    #+#             */
/*   Updated: 2022/06/14 14:23:18 by susami           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "tester.h"

int	main(void)
{
	char	*line;

	line = get_next_line(STDIN_FILENO);
	while (line)
	{
		printf("%s", line);
		line = get_next_line(STDIN_FILENO);
	}
	return (0);
}

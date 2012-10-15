-- PS5P01 Arnold Christopher Koroa A0092101Y

split = foldr -- only fill in at the indicated place,
		(\ x y -> -- do not change anything else in the skeleton
			if head y == []
				then [x : head y] ++ (tail y)
				else if (	
							(x * (head (head y)) > 0) -- same sign
							|| ( (x==0) && (head (head y) >= 0) ) -- one is zero the other is positive or 0
							|| ( (x>=0) && (head (head y) == 0) ) -- one is zero the other is positive or 0
						)
					then [x : head y] ++ (tail y)
					else [x]:y
		)
		[[]]

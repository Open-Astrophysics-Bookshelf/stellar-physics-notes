! saha.f
! module contain function and driver program to find the NSE abundances
! of a 56Ni - 4He mixture.
!
! AST 840, Spring 2008
! Edward Brown, Michigan State University
!
module saha
	implicit none
	real :: T9, rho7
	real, parameter, private :: aX = 1.0/14.0, &
		& aR = -13.0/14.0, aT = 39.0/28.0, Q = 72.8, NQ = 9.40e3 
	
contains
	function find_xhe(x4) result(r)
		implicit none
		real, intent(in) :: x4
		real :: r
		
		r = x4 - (1.0-x4)**aX * NQ * rho7**aR * T9**aT * exp(-Q/T9)
	end function find_xhe
	
	function find_T(T) result(r)
		implicit none
		real, intent(in) :: T
		real :: r
		
		T9 = T
		r = find_xhe(0.5)
	end function find_T
end module saha

program solve_nse
	use saha
	implicit none
	integer :: i,ierr
	real :: x4, Thalf
	real, parameter :: tol = 1.0e-8
	interface
		function bisection(x1,x2,tol,ierr,func)
 			implicit none
			real, intent(in) :: x1,x2,tol
			integer, intent(out) :: ierr
			real :: bisection
			interface
				function func(x)
					implicit none
					real, intent(in) :: x
					real :: func
				end function func
			end interface
		end function bisection
	end interface
	
	rho7 = 1.0
	! vary T9 from 4.5 to 6.5 and solve for x
	print '(a5,tr2,2(a11,tr2))','T9','X4','X56'
	print '("=====",tr2,2(11("="),tr2))'
	do i = 450, 650
		T9 = real(i)*0.01
		x4 = bisection(0.0,1.0,tol,ierr,find_xhe)
		if (ierr < 0) stop
		print '(f5.2,tr2,2(g11.4,tr2))',T9,x4,1.0-x4
	end do
	
	! now find temperature at which xhe = xni = 0.5
	Thalf = bisection(5.9,6.0,tol,ierr,find_T)
	if (ierr < 0) stop
	print '(/,A,f6.3)','T9(X4 = X56) = ',Thalf
end program solve_nse
	
	
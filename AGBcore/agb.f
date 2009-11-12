module agb_end
	implicit none
	real :: initial_mass, initial_core_mass
	real :: wind_loss_coeff

contains

function fcn(m) result(D)
	implicit none
	real, intent(in) :: m
	real :: D
	real :: m0, mc0, c
	
	m0 = initial_mass
	mc0 = initial_core_mass
	c = wind_loss_coeff
	
	D = m**2 - m0**2 + c*((m-0.52)**1.5 - (mc0-0.52)**1.5)
end function fcn
end module agb_end

program wd_mass
	use agb_end
	implicit none
	real :: m1, m2, tol, final_core_mass
	integer :: ierr
	character(len=10) :: arg
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
	
	if (command_argument_count() /= 3) then
		call get_command_argument(0,arg)
		print *,'usage: ',trim(arg), ' <initial mass> <initial core mass> <wind loss coeff>'
		stop
	end if
	
	call get_command_argument(1,arg)
	read(arg,*) initial_mass
	call get_command_argument(2,arg)
	read(arg,*) initial_core_mass
	call get_command_argument(3,arg)
	read(arg,*) wind_loss_coeff
	
	m1 = 0.52
	m2 = 1.4
	tol = epsilon(m2)
	final_core_mass = bisection(m1,m2,tol,ierr,fcn)
	if (ierr > -2) then
		print *,initial_mass, initial_core_mass, final_core_mass
	end if
end program wd_mass

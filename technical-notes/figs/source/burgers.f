module burgers
	integer, parameter :: conservative = 1
	integer, parameter :: nonconservative = 2

	contains
	
	subroutine integrate(u,dx,dt,t,tend,solver)
		real, dimension(:), intent(inout) :: u
		real, intent(in) :: dx,dt,tend
		real, intent(inout) :: t
		integer, intent(in) :: solver
		real, dimension(size(u)) :: unew
		real :: dtdx

		dtdx = dt/dx
		do
			if (t >= tend) exit
			select case (solver)
				case (conservative)
					call conservative_upwind(u,dtdx,unew)
				case (nonconservative)
					call nonconservative_upwind(u,dtdx,unew)
				case default
					stop 'non-existent solver requested'
			end select
			u = unew
			t = t + dt
		end do
	end subroutine integrate
	
	subroutine conservative_upwind(u,dtdx,unew)
		real, dimension(:), intent(in) :: u
		real, intent(in) :: dtdx
		real, dimension(:), intent(out) :: unew
		real, dimension(size(u)) :: u2
		integer :: m
		
		m = size(u)
		u2 = u**2
		unew = u
		unew(2:m) = u(2:m) - 0.5*dtdx*(u2(2:m)-u2(1:m-1))
	end subroutine conservative_upwind
	
	subroutine nonconservative_upwind(u,dtdx,unew)
		real, dimension(:), intent(in) :: u
		real, intent(in) :: dtdx
		real, dimension(:), intent(out) :: unew
		integer :: m
	
		m = size(u)
		unew = u
		unew(2:m) = u(2:m) - dtdx*u(2:m)*(u(2:m)-u(1:m-1))
	end subroutine nonconservative_upwind

end module burgers

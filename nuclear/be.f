module nuclear_mass
implicit none
real, parameter :: av = 15.5, as = -16.6, aa = -22.7, ac = -0.71, &
	onethird = 1./3

contains
function B(N,Z)
	implicit none
	integer, intent(in) :: N,Z
	real :: B
	integer :: A
	real :: A13, A23
	
	A = N + Z
	A13 = A**onethird
	A23 = A13**2
	B = av * A + as*A23 + aa*(N-Z)**2 / A + ac*Z**2 / A13
end function B

function Zstar(A)
	implicit none
	integer, intent(in) :: A
	integer :: Zstar
	real, parameter :: twothird = 2.0*onethird
	
	Zstar = nint(0.5*A/(1.0 + 0.25*ac*A**twothird/aa))
end function Zstar

function Sn(N,Z)
	implicit none
	integer, intent(in) :: N, Z
	real :: Sn
	
	Sn = B(N,Z) - B(N-1,Z)
end function Sn

function Sp(N,Z)
	implicit none
	integer, intent(in) :: N, Z
	real :: Sp
	
	Sp = B(N,Z) - B(N,Z-1)
end function Sp

end module nuclear_mass
program main
	use nuclear_mass
	implicit none
	integer, parameter :: Amin = 4, Amax = 200
	integer, parameter :: Zmin = 2, Zmax = 82
	integer, parameter :: Nmin = 2, Nmax = 120
	integer :: A, Z, N, Zs, Ns
	open(unit=10,file='Zstar.data')
	do A = Amin, Amax
		Z = Zstar(A)
		N = A-Z
		write(10,'(i4,tr1,i4,tr1,f8.3)') Z, N, B(N,Z)/A
	end do
	close(10)
	open(unit=10,file='neutron_drip.data')
	do Z = Zmin, Zmax
		Ns = Z
		do
			if (Sn(Ns,Z) <= 0.0 ) exit 
			Ns = Ns + 1
		end do
		Ns = Ns-1
		write(10,'(i4,tr1,i4,tr1,f8.3)') Z, Ns, Sn(Ns,Z)
	end do
	close(10)
	open(unit=10,file='proton_drip.data')
	do N = Nmin, Nmax
		Zs = N/2
		do
			if (Sp(N,Zs) <= 0.0 ) exit 
			Zs = Zs + 1
		end do
		Zs = Zs-1
		write(10,'(i4,tr1,i4,tr1,f8.3)') Zs, N, Sp(N,Zs)
	end do
	close(10)
end
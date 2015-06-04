program steepening
	use burgers
	integer :: N
	real :: ul, ur, xl, xr, dx
	real :: dtdx, dt, tend, t, t_next, t_last_write, write_interval
	real, dimension(:), allocatable :: u,x,slope
	integer :: i,frame,front(1)
	character(len=*), parameter :: inputfile = 'steepening.in'
	character(len=*), parameter :: filename_base = 'data/steepening_'
	character(len=80) :: filename

	namelist /domain/ xl, xr, dx
	namelist /integration/ ul, ur, tend, dt
	open (unit = 10,file=inputfile,status='old')
	read(10,nml=domain)
	read(10,nml=integration)
	close(10)
	
	N = nint((xr-xl)/dx) + 1
	dtdx = dt/dx
	write (*,'(a)') 'solving Burgers'' equations dt(u) + dx(0.5*u**2) = 0'
	write (*,'(a,f4.1,a,f4.1,a,es9.2,a,i5,a)')  &
				& 'on domain x = [',xl,',',xr,'] with dx = ',dx,' (N = ',N,')'
	write (*,'(a,f4.1,a,es9.2)') 't = [0, ',tend,'] with dt = ',dt
	write (*,'(a,es9.2)') 'dt/dx = ',dtdx
	
	allocate(u(N),x(N),slope(N))
	
	x = [ (xl + i*dx, i=0,N-1) ]
	u = ur + (ul-ur)*0.5*(1.0-tanh(x/(50.0*dx)))
	t = 0.0
	frame = 0
	write_interval = (tend-t)/10.0
	do
		frame = frame + 1
		write(filename,'(a,i0,a)') trim(filename_base),frame,'.data'
		open (unit = 11,file=filename)
		write (11,'(f7.3)') t
		write (11,'(2(f7.3,tr1))') (x(i),u(i),i = 1,N)
		close (11)
		! compute width of front
		slope(1) = 0.0
		slope(2:N) = abs((u(2:N)-u(1:N-1))/dx)
		front = maxloc(slope)
		print '(3(a,f6.3))','front width (t =',t,') =',(ul-ur)/maxval(slope),', centered at x =',x(front)
		if (t >= tend) exit
		t_last_write = t
		t_next = t + write_interval
		call integrate(u,dx,dt,t,t_next,conservative)
		
	end do
	deallocate(u,x,slope)
	
end program steepening

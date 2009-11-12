! zbrent.f
! implements brent's method for finding the root x1 of a one-dimensional function
! func.
!
! modified from the numerical recipes algorith zbrent.f90
!
! AST 911, Spring 2008
! Edward Brown, Michigan State University
!
	function zbrent(x1,x2,tol,ierr,func)
 	implicit none
	real, intent(in) :: x1,x2,tol
	integer, intent(out) :: ierr
	real :: zbrent
	interface
		function func(x)
		implicit none
		real, intent(in) :: x
		real :: func
		end function func
	end interface
	integer, parameter :: itmax=100
	real, parameter :: eps=epsilon(x1)
	integer :: iter
	real :: a,b,c,d,e,fa,fb,fc,p,q,r,s,tol1,xm
	
	ierr = 0
	a=x1
	b=x2
	fa=func(a)
	fb=func(b)
	if ((fa > 0.0 .and. fb > 0.0) .or. (fa < 0.0 .and. fb < 0.0)) then
		print *,'root must be bracketed for zbrent'
		ierr = -2
		zbrent = tiny(1.0)
		return
	end if
	c=b
	fc=fb
	do iter=1,itmax
		if ((fb > 0.0 .and. fc > 0.0) .or. (fb < 0.0 .and. fc < 0.0)) then
			c=a
			fc=fa
			d=b-a
			e=d
		end if
		if (abs(fc) < abs(fb)) then
			a=b
			b=c
			c=a
			fa=fb
			fb=fc
			fc=fa
		end if
		tol1=2.0*eps*abs(b)+0.5*tol
		xm=0.5*(c-b)
		if (abs(xm) <= tol1 .or. fb == 0.0) then
			zbrent=b
			return
		end if
		if (abs(e) >= tol1 .and. abs(fa) > abs(fb)) then
			s=fb/fa
			if (a == c) then
				p=2.0*xm*s
				q=1.0-s
			else
				q=fa/fc
				r=fb/fc
				p=s*(2.0*xm*q*(q-r)-(b-a)*(r-1.0))
				q=(q-1.0)*(r-1.0)*(s-1.0)
			end if
			if (p > 0.0) q=-q
			p=abs(p)
			if (2.0*p  <  min(3.0*xm*q-abs(tol1*q),abs(e*q))) then
				e=d
				d=p/q
			else
				d=xm
				e=d
			end if
		else
			d=xm
			e=d
		end if
		a=b
		fa=fb
		b=b+merge(d,sign(tol1,xm), abs(d) > tol1 )
		fb=func(b)
	end do
	print *,'zbrent: exceeded maximum iterations'
	zbrent=b
	ierr = -1
	end function zbrent

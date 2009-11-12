! bisect.f
! finds a root of a function f(x) via bisection.
! input: 	x1, x2  := brackets for root
!					tol			:= requested accuracy
!					fcn			:= pointer to function f(x)
! output: ierr		:= error flag
!											 0, normal return
!											-2, root not bracketed
!											-1,	too many iterations
!					r				:= the root
!
! AST 840, Spring 2008
! Edward Brown, Michigan State University
!
function bisection(x1,x2,tol,ierr,fcn) result(r)
  implicit none
  real,intent(in):: x1,x2,tol
  real:: r
	integer, intent(out) :: ierr
  interface
    function fcn(x)
      real,intent(in):: x
      real:: fcn
    end function fcn
  end interface
  integer :: max_iter = digits(1.0)
  integer:: j
  real:: dx,f,fmid,xmid
  
	ierr = 0
  fmid = fcn(x2)
  f = fcn(x1)
  if (f*fmid >= 0.0) then
		print *,'root not bracketed'
		ierr = -2
		r = tiny(1.0)
		return
	end if
  if (f < 0.0) then
    r = x1
    dx = x2-x1
  else
    r = x2
    dx = x1-x2
  end if
  do j = 1, max_iter
    dx = dx*0.5
    xmid = r+dx
    fmid = fcn(xmid)
    if (fmid <= 0.0) r = xmid
    if (abs(dx) < tol .or. fmid == 0.0) return
  end do
	ierr = -1
  print *, 'too many iterations in root_bisection'
end function bisection

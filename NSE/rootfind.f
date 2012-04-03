! rootfind.f
! finds a root of a function f(x) via bisection.
!
! AST 840, Spring 2010
! Edward Brown, Michigan State University
!
module rootfind

  integer, parameter ::   root_not_bracketed = -1, &
                        & too_many_iterations = -2
  contains
  function bisection(x1,x2,tol,fcn,ipar,rpar,ierr) result(r)
    ! inputs
    ! x1, x2 := brackets for root, such that either
    ! fcn(x1) > 0 and fcn(x2) < 0, or vice-versa
    real,intent(in):: x1, x2
    ! the desired tolerance of the root. solver quits when 
    ! abs(x1-x2) < tol
    real, intent(in) :: tol
    ! the user-supplied function f(x) such that f(x_root) = 0
    interface
      function fcn(x,ipar,rpar,ierr)
        real,intent(in):: x
        integer, dimension(:), intent(inout) :: ipar
        real, dimension(:), intent(inout) :: rpar
        integer, intent(out) :: ierr
        real:: fcn
      end function fcn
    end interface
    ! an array of integer (ipar) and real (rpar) parameters
    ! to be passed to fcn. These can be altered by fcn.
    integer, dimension(:), intent(inout) :: ipar
    real, dimension(:), intent(inout) :: rpar
    ! ierr == 0 means all okays
    integer, intent(out) :: ierr
    ! the root
    real:: r
    
    ! maximum number of iteration.  Since on each iteration
    ! the range abs(x1-x2) is cut in half, we should need 
    ! digits(1.0) iterations to reach a relative 
    ! tolerance of machine precision
    integer :: max_iter = digits(1.0)
    integer:: j
    real:: dx,f,fmid,xmid

    ierr = 0
    fmid = fcn(x2,ipar,rpar,ierr)
    if (ierr /= 0) then
      print *,'unable to evalute function at x = ',x2
      r = tiny(1.0)
      return
    end if
    f = fcn(x1,ipar,rpar,ierr)
    if (ierr /= 0) then
      print *,'unable to evalute function at x = ',x1
      r = tiny(1.0)
      return
    end if
    if (f*fmid >= 0.0) then
      print *,'root not bracketed'
      ierr = root_not_bracketed
      r = tiny(1.0)
      return
    end if
    
    ! orient search
    if (f < 0.0) then
      r = x1
      dx = x2-x1
    else
      r = x2
      dx = x1-x2
    end if
  
    ! main loop
    do j = 1, max_iter
      dx = dx*0.5
      xmid = r+dx
      fmid = fcn(xmid,ipar,rpar,ierr)
      if (fmid <= 0.0) r = xmid
      if (abs(dx) < tol .or. abs(fmid) < tol) return
    end do
    ierr = too_many_iterations
    print *, 'too many iterations in root_bisection'
  end function bisection
end module rootfind

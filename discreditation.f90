module grille
    use precision, only : dp
    use parametre, only : n, L, x0, sigma, A
    implicit none
    private
    real(dp),allocatable :: X(:), Q(:)
    real(dp) :: dx
    integer :: i
    public :: initialize_grid, X, Q, dx

    contains
    
    subroutine initialize_grid()

        if (allocated(X)) deallocate(X, Q)
        dx = L /(n-1)
        allocate(X(n), Q(n))
        do i = 1,n 
            X(i) = (i-1)*dx
            Q(i) = A*exp(-0.5*((X(i)-x0)/sigma)**2)
        end do

    end subroutine initialize_grid

end module grille

module solver
    use precision, only : dp
    use parametre, only : n, dt, t_max, lambda, rho, cp, h, T_inf,T_init
    use grille, only : X, Q, dx
    implicit none
    private
    real(dp), allocatable :: T(:), T_new(:), matrix_systeme(:,:), second_member(:)
    real(dp) :: r, alpha
    integer :: i
    public :: build_matrix, thomas_solver, T, T_new, init_temperature
    


    contains
    subroutine init_temperature()
        if (allocated(T)) deallocate(T)
        allocate(T(n))
        T = T_init
    end subroutine init_temperature

    subroutine build_matrix()
        if (allocated(matrix_systeme)) deallocate(matrix_systeme)
        if (allocated(second_member)) deallocate(second_member)
        allocate(matrix_systeme(n,3), second_member(n))
        


        alpha = lambda/(rho*cp)

        r = lambda*dt/(rho*cp*dx**2)
        
        matrix_systeme = 0.0_dp
        second_member = 0.0_dp

        matrix_systeme(1, 2) = lambda/dx + h
        matrix_systeme(1, 3) = -lambda/dx
        second_member(1) = h*T_inf

        do i = 2, n-1
            matrix_systeme(i, 1) = -r/2
            matrix_systeme(i, 2) = 1.0_dp *(1 + r)
            matrix_systeme(i, 3) = -r/2

            second_member(i) = r/2.0_dp*T(i-1) + 1.0_dp*(1-r) * T(i) + r/2.0_dp*T(i+1) +alpha*Q(i)*dt/lambda
        end do

        matrix_systeme(n, 1) = -lambda
        matrix_systeme(n, 2) = lambda + h*dx
        second_member(n) = h*dx*T_inf

    end subroutine build_matrix


    subroutine thomas_solver()

        if (.not. allocated(T_new)) allocate(T_new(n))
        do i = 2, n
            matrix_systeme(i, 2) = matrix_systeme(i, 2) - matrix_systeme(i, 1)*matrix_systeme(i-1, 3)/matrix_systeme(i-1, 2)
            second_member(i) = second_member(i) - matrix_systeme(i, 1)*second_member(i-1)/matrix_systeme(i-1, 2)
        end do

        T_new(n) = second_member(n)/matrix_systeme(n, 2)
        do i = n-1, 1, -1
            T_new(i) = (second_member(i) - matrix_systeme(i, 3)*T_new(i+1))/matrix_systeme(i, 2)
        end do

    end subroutine thomas_solver
        
        

end module solver

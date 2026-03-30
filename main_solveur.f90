program main_solveur
    use precision
    use parametre
    use grille
    use solver
    use mod_io
    implicit none
    integer :: n_etape, unit_id , gp, i
    real(dp) :: t_courant
    
    call read_parameters('parametre.txt')
    call initialize_grid()
    call init_temperature()
    n_etape = 1
     
    
    open(newunit=unit_id, file='temp_en_fon_temps', status='replace', action='write')

    open(newunit=gp, file='plot_all.gp', action='write')
    write(gp,*) "set terminal gif animate delay 20"
    write(gp,*) "set output 'evolution_temperature.gif'"
    do while (dt*n_etape<=t_max)
        t_courant = dt*n_etape
        call build_matrix()
        call thomas_solver()
        
        call save_resultat(unit_id, t_courant, T_new)      
            
        if (mod(n_etape, 10) == 0) then
            write(gp, '(A)') "set yrange [292:400]"
            write(gp, '(A)') "set xlabel 'x (m)'"
            write(gp, '(A)') "set ylabel 'T (K)'"
            write(gp, '(A,F10.2,A)') "plot '-' with lines title 't=", t_courant, "s"            
            do i = 1, n
                write(gp, *) X(i), T_new(i)
            end do
            write(gp, *) "e"
        end if
        T = T_new
        n_etape = n_etape + 1
    end do
    close(gp)
    close(unit_id)

   

    
   
    

   

end program main_solveur

    

%% Information
%{

    File name: HW1Q1.m
    Description: Solution script of the 1st question of the 
    KOM501E(Control of systems with parameter uncertainty) homework 1.
    Author: Mehmet Kilic
    Date: 11/11/2023

%}
%% Cleeaning and setting up numeric formatting

clear;
close all;
clc;

format longg;

%% Definition of the characteristic polynomial

syms s q_1 q_2 q_3 q_4

a_5 = 1;
a_4 = 345 / 53 + 73 / 24 * q_1;
a_3 = 184 / 15 + 211919 / 47520 * q_1 + 12 / 17 * q_4 ;
a_2 = 497 / 16 + 1112447 / 49680 * q_1 + 12 / 17 * q_3 + 11 / 26 * q_4 ;
a_1 = 384 / 17 + 6325669 / 364320 * q_1 + 12 / 17 * q_2 + 9 / 32 * q_3 + 3 / 35 * q_4;
a_0 = 1533 / 47 + 48326 / 1587 * q_1 + 7 / 50 * q_2 + q_4 / 199;

P_sq = a_5 * s ^ 5 + a_4 * s ^ 4 + a_3 * s ^ 3 + a_2 * s ^ 2 + a_1 * s ^ 1 + a_0 * s ^ 0;

%% Calculation of the roots for the given interval

interval_vector = linspace( -1, 1, 10 );
roots_of_polynomials = zeros(5,10^4);
root_counter = 0;

for q1 = interval_vector
    for q2 = interval_vector
        for q3 = interval_vector
            for q4 = interval_vector
                P_s = subs( P_sq, { q_1, q_2, q_3, q_4 }, { q1, q2, q3, q4 } );
                roots_of_Ps = vpasolve( P_s, s );
                root_counter = root_counter + 1;
                fprintf( 'Roots of %d. polynomial is being calculated..\n', root_counter )
                roots_of_polynomials( :, root_counter ) = double( roots_of_Ps );
            end
        end
    end
end

real_part_of_the_roots = real( roots_of_polynomials );
imag_part_of_the_roots = imag( roots_of_polynomials );

fprintf( '\n\nCalculation of the roots completed!\n' )

%% PLotting the pole spread

figure( 1 )
plot( real_part_of_the_roots( 1, : ), imag_part_of_the_roots( 1, : ), 'k.' ); 
hold on;
grid on; 
grid minor;
plot( real_part_of_the_roots( 2, : ), imag_part_of_the_roots( 2, : ), 'g.' );
plot( real_part_of_the_roots( 3, : ), imag_part_of_the_roots( 3, : ), 'b.' );
plot( real_part_of_the_roots( 4, : ), imag_part_of_the_roots( 4, : ), 'r.' );
plot( real_part_of_the_roots( 5, : ), imag_part_of_the_roots( 5, : ), 'y.' );
xlabel( 'Real axis' ); 
ylabel( 'Imaginary axis' );
legend( 'Pole-1', 'Pole-2', 'Pole-3', 'Pole-4', 'Pole-5', 'Location', 'northoutside', 'NumColumns', 5 );
title('The pole-spread of the polynomial (for ηi = 10)')

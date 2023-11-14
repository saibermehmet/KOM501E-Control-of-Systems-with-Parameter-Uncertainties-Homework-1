
%% Information
%{

    File name: HW1Q6.m
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

%% Polinomial( P( jw ) ) for the desired frequency interval

% Gridding frequency
wgrid = 100;
% Minumum and Maximum frequency
w_min = 0;  w_max = 5;  %1.5
% Frequency vector
w = linspace( w_min, w_max, wgrid );
% The Polinomial( P( jw ) )
p_jw = subs( P_sq, s, w * 1j );           
 % The Polinomial( P( j0 ) )
p_j0 = subs( P_sq, s, 0 * 1j );          

%% Gridding uncertain parameters for q1, q2, q3, q4
n = 10;
q1_min = -1; q1_max = 1;
q2_min = -1; q2_max = 1;
q3_min = -1; q3_max = 1;
q4_min = -1; q4_max = 1;

q1_all = linspace( q1_min, q1_max, n);
q2_all = linspace( q2_min, q2_max, n);
q3_all = linspace( q3_min, q3_max, n);
q4_all = linspace( q4_min, q4_max, n);

% Plotting
figure( ( 1 ) );
hold on;
counter = 0;

for q1_sample = q1_all
    for q2_sample = q2_all
        for q3_sample = q3_all
            for q4_sample = q4_all
                counter = counter + 1;
                p_jw_q1q2q3q4 = double( subs( p_jw, { q_1, q_2, q_3, q_4 }, { q1_sample, q2_sample, q3_sample, q4_sample } ) );
                p_jw_re = real( p_jw_q1q2q3q4 );
                p_jw_im = imag( p_jw_q1q2q3q4 );
                fprintf( '%d. polynomial is being calculated..\n', counter )
                plot( p_jw_re, p_jw_im, 'k' )
            end
        end
    end
end

plot( 0, 0, 'ro' )
sgtitle( 'Mikhailov Plot' )
xlabel( 'Real Part of P(jw)' )
ylabel( 'Imaginary Part of P(jw)' )
grid on; 
grid minor;
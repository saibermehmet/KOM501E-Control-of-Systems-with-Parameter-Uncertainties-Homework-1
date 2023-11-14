
%% Information
%{

    File name: HW1Q5.m
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

%% Calculation of even and odd polynomials

P_sq_new = subs( P_sq, s, s-2 );
% P_sq_new = simplify( P_sq_new );
P_sq_new = expand( P_sq_new );

ps_new_coeffs = coeffs( P_sq_new, s );

a5_new = ps_new_coeffs( 6 );
a4_new = ps_new_coeffs( 5 );
a3_new = ps_new_coeffs( 4 );
a2_new = ps_new_coeffs( 3 );
a1_new = ps_new_coeffs( 2 );
a0_new = ps_new_coeffs( 1 );

Ps_even = a4_new * s ^ 4 + a2_new * s ^ 2 + a0_new * s ^ 0;
Ps_odd  = a5_new * s ^ 5 + a3_new * s ^ 3 + a1_new * s ^ 1;

%% Polinomial( P( jw ) ) for the desired frequency interval

% Gridding frequency
wgrid = 100;
% Minumum and Maximum frequency
w_min = 0;  w_max = 6;
% Frequency vector
w = linspace(w_min,w_max,wgrid);
% Even Polinomial( P( jw ) )
p_jw_even = subs( Ps_even, s, w * 1j );
% Odd Polinomial( P( jw ) )
p_jw_odd  = imag( subs( Ps_odd, s, w * 1j ) );           

% First q1 = -1 and q2 = q3 = q4 = 0 
p_jw_even_first = double( subs( p_jw_even, { q_2, q_3, q_4, q_1 }, {0, 0, 0,-1 } ) );
p_jw_odd_first = double( subs( p_jw_odd, { q_2, q_3, q_4, q_1 }, { 0, 0, 0, -1 } ) );

% First q1 = 0 and q2 = q3 = q4 = 0 
p_jw_even_second = double( subs( p_jw_even,{ q_2, q_3, q_4, q_1}, { 0, 0, 0, 0 } ) );
p_jw_odd_second = double( subs( p_jw_odd, { q_2, q_3, q_4, q_1}, { 0, 0, 0, 0 } ) );

% First q1 = -1 and q2=q3=q4 = 0 
p_jw_even_third = double( subs( p_jw_even, { q_2, q_3, q_4, q_1 }, { 0, 0, 0, 1 } ) );
p_jw_odd_third = double( subs( p_jw_odd, {q_2, q_3, q_4, q_1 }, { 0, 0, 0, 1 } ) );

%% PLotting the Even and Odd Polinomial

figure( 1 );
plot( w, p_jw_even_first, 'k-', 'LineWidth', 1.5 );
hold on;
plot( w, p_jw_odd_first, 'r-', 'LineWidth', 1.5 );
xlabel( 'Frequency(rad/s)' );
ylabel( 'P(jw)' );
grid on; 
grid minor;
legend( 'P(jw)_{Even}', 'P(jw)_{Odd}' );
title( "q_1 = -1, q_2 = 0, q_3 = 0 and q_4 = 0" );

figure( 2 );
plot( w,p_jw_even_second, 'k-', 'LineWidth', 1.5 );
hold on;
plot( w,p_jw_odd_second, 'r-', 'LineWidth', 1.5 );
xlabel( 'Frequency(rad/s)' );
ylabel( 'P(jw)' );
grid on; 
grid minor;
legend( 'P(jw)_{Even}', 'P(jw)_{Odd}' );
title( "q_1 = 0, q_2 = 0, q_3 = 0 and q_4 = 0" );

figure( 3 );
plot( w, p_jw_even_third, 'k-', 'LineWidth', 1.5 );
hold on;
plot( w, p_jw_odd_third, 'r-', 'LineWidth', 1.5 );
xlabel( 'Frequency(rad/s)' );
ylabel( 'P(jw)' );
grid on; 
grid minor;
legend( 'P(jw)_{Even}', 'P(jw)_{Odd}' );
title( "q_1 = 1, q_2 = 0, q_3 = 0 and q_4 = 0" );

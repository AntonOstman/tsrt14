function q_normalized = qnorm(q)
    % Calculate quaternion magnitude
    q_mag = norm(q);
    
    % Normalize quaternion
    q_normalized = q*sign(q(1)) / q_mag;
end

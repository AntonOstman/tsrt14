function q_normalized = normalize_quaternion(q)
    % Calculate quaternion magnitude
    q_mag = norm(q);
    
    % Normalize quaternion
    q_normalized = q / q_mag;
end

https://docs.google.com/document/d/18DwCtJNNTACFD2C5Xk2myp7AdQSU4xrSu1TXvqUa_7I/edit

Computer Vision Project
=======================

1. Mark object/Give object position (UNMESH)

    1. Input: 1st frame

    2. Use mouse clicks and the ginput function

    3. Outputs the coordinates of the centre and the radii of the ellipse

    4. function [centre, radii] = getObjectPosition(frame)

2. Compute distribution of the object-window - (16 bins per channel - leave as a parameter) (UNMESH)

    5. Takes the n_h pixels inside the window (ellipse inside the rectangle) and computes a histogram

    6. Input: the rectangular window - the array of pixel values inside the object-window

    7. Use Epanechnikov kernel to compute the distribution

    8. Output: The distribution - a 16x16x16 array -- leave the 16 as a parameter

    9. function hist = computeDistribution(window)

3. Function to evaluate Bhattacharya coefficient (SIDDHANT)

    10. Input: 2 distributions

    11. Compute the Bhattacharya coefficient using formula (17) from paper

    12. function coeff = computeBhattacharyaCoefficient(d1, d2)

4. Function to compute mean-shifted position - (1 iteration of while) (UNMESH)

    13. Input: distributions q_u (from frame i) and p_u(y_0) (from frame i+1), frames i and i+1,y_0,radius in current frame,radius in next frame

    14. Compute the mean-shifted position using formulae (26) and (25).

    15. Output the mean-shifted position

    16. function shiftedPos = computeMeanShiftPosition(frame1, q_u, frame2, p_u)

5. Function to mark the tracked object (SIDDHANT)

    17. Inputs: frame, centre, radii of ellipse

6. Main function (SIDDHANT)

    18. Get input, object positions

    19. For each frame i

        1. computeDistribution q_u for frame i at y0i with size = original size_i

        2. computeDistribution p_u for frame i+1 at y0i with size = 90%, 95%, 100%, 105%, 110% of original size

        3. Create an array to store the final BhattacharyaCoefficients for each object size and another to store the final positions

        4. Iterate over all p_u s

            1. While (convergence criteria)

                1. computeBhattacharyaCoefficient

                2. computeMeanShiftPosition update

                3. Step 4 of the algorithm from paper

                4. Update p_u for this new position

            2. Store the last computed Bhattacharya coefficient, and the final position in the respective arrays

        5. Choose that object size which gives the highest coefficient, and get that final position vector

        6. Display/Store frame i+1

        7. Save y0(i+1) and original size_(i+1)

    20. Close video display/Save video to file.


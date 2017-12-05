
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author dsli
 */
public class Atlassian1 {

    /*
     * Complete the function below.
     */
    static int[] rearrange(int[] elements) {
        String[] binRepresentations = new String[elements.length];
        boolean[] used = new boolean[elements.length];

        // First, gather the binary representations in String format
        for (int i = 0; i < elements.length; i++) {
            int element = elements[i];
            String binaryRep = "";
            while (element > 0) {
                int rem = element % 2;
                binaryRep = rem + binaryRep;
                element /= 2;
            }
            binRepresentations[i] = binaryRep;
        }

        // Set the max number initially to the max in the elements
        int max = 0;
        for (int i = 0; i < elements.length; i++) {
            if (elements[i] > max) {
                max = elements[i];
            }
        }

        // This loop will construct the elements to be returned, in proper order
        int[] orderedElements = new int[elements.length];
        // Now, count the number of ones and repeatedly insert based on that, breaking ties based on decimal value, storing in a HashMap for this sake
        for (int n = 0; n < orderedElements.length; n++) {
            // This List will be used to track the elements with the same number of ones
            ArrayList<Integer> decimalValues = new ArrayList<Integer>();
            int minOnes = max;
            // Now, find the elements with the LEAST number of ones, those will go first in the array
            for (int i = 0; i < binRepresentations.length; i++) {
                int ones = countOnes(binRepresentations[i]);
                if (ones < minOnes) {
                    minOnes = ones;
                    decimalValues.clear();
                    decimalValues.add(elements[i]);
                } else if (ones == minOnes) {
                    decimalValues.add(elements[i]);
                }
            }

            if (decimalValues.size() == 1) {
                int zerothElement = decimalValues.remove(0);
                orderedElements[n] = zerothElement;
            } else {
                while (decimalValues.size() > 0) {
                    int minIndex = decimalValues.indexOf(Collections.min(decimalValues));
                    orderedElements[n] = decimalValues.remove(minIndex);
                    n++;
                }
            }

        }

        // return the list at the end
        return orderedElements;
    }

    static int countOnes(String binaryString) {
        int n = 0;
        for (int i = 0; i < binaryString.length(); i++) {
            if (binaryString.charAt(i) == '1') {
                n++;
            }
        }
        return n;
    }

    public static void main(String[] args) throws IOException {
        int[] array = new int[] {1, 2, 3};
        int[] rearrangeArray = rearrange(array);
        for (int i = 0; i < rearrangeArray.length; i++) {
            System.out.print(rearrangeArray[i] + " ");
        }
    }
}

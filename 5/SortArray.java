import java.util.Arrays;

public class SortArray {
    public static void main(String[] args) {
        int[] array = {5, 2, 8, 1, 9};

        // Sort the array in ascending order
        Arrays.sort(array);

        // Print the sorted array
        System.out.println("Sorted array: " + Arrays.toString(array));
    }
}
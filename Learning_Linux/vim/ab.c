#include <stdio.h>

void sortTheArray(int array[], int size)
{
    for(int i = 0; i < size - 1; i++)
    {
        for(int j = 0; j < size - 1; i++)
        {
            if(array[j] > array[j+1])
            {
                int temp = array[j];
                array[j] = array[j+1];
                array[j+1] = temp;
            }
        }
    }
}
int main()
{
    int array[] = {66, 34, 54, 98, 13};
    int size = sizeof(array)/sizeof(array[0]);
    sortTheArray(array, size);
    return 0;
}

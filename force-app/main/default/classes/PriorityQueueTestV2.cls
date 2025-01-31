
@isTest
private class PriorityQueueTestV2 {

    @isTest
    static void testSizeIsCorrectAfterAddingElements() {
        PriorityQueue queue = new PriorityQueue();

        queue.add(10);
        queue.add(20);
        queue.add(30);

        System.assertEquals(3, queue.heap.size());
    }

    @isTest
    static void testPeekReturnsCorrectElement() {
        PriorityQueue queue = new PriorityQueue();

        queue.add(10);
        queue.add(20);
        queue.add(30);

        System.assertEquals(30, queue.peek());
    }

    @isTest
    static void testPollRemovesCorrectElement() {
        PriorityQueue queue = new PriorityQueue();

        queue.add(10);
        queue.add(20);
        queue.add(30);

        System.assertEquals(30, queue.poll());
        System.assertEquals(20, queue.poll());
        System.assertEquals(10, queue.poll());
    }

    @isTest
    static void testSizeIsCorrectAfterRemovingElements() {
        PriorityQueue queue = new PriorityQueue();

        queue.add(10);
        queue.add(20);
        queue.add(30);

        queue.poll();
        System.assertEquals(2, queue.heap.size());

        queue.poll();
        System.assertEquals(1, queue.heap.size());

        queue.poll();
        System.assertEquals(0, queue.heap.size());
    }

    @isTest
    static void testIsEmptyReturnsCorrectValue() {
        PriorityQueue queue = new PriorityQueue();

        System.assertEquals(true, queue.isEmpty());

        queue.add(10);
        System.assertEquals(false, queue.isEmpty());

        queue.poll();
        System.assertEquals(true, queue.isEmpty());

    }

    @isTest
    static void testPeekThrowsExceptionWhenQueueIsEmpty() {
        PriorityQueue queue = new PriorityQueue();

        Boolean caughtException = false;

        try {
            queue.peek();
        } catch (PriorityQueue.PriorityQueueException e) {
            caughtException = true;
        }

        System.assertEquals(true, caughtException);
    }

    @isTest
    static void testPollThrowsExceptionWhenQueueIsEmpty() {
        PriorityQueue queue = new PriorityQueue();

        Boolean caughtException = false;

        try {
            queue.poll();
        } catch (PriorityQueue.PriorityQueueException e) {
            caughtException = true;
        }

        System.assertEquals(true, caughtException);
    }
}
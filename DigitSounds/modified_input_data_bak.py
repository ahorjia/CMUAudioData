import os
import urllib
import numpy as np
from os import listdir
from os.path import isfile, join

class DataSet(object):
    def __init__(self, images, labels):
        assert images.shape[0] == labels.shape[0], (
          "images.shape: %s labels.shape: %s" % (images.shape, labels.shape))
        self._num_examples = images.shape[0]

        images = images.reshape(images.shape[0], images.shape[1] * images.shape[2])

        # Convert from [0, 255] -> [0.0, 1.0].
        images = images.astype(np.float32)
        images = np.multiply(images, 1.0 / 255.0)

        self._images = images
        self._labels = labels
        self._epochs_completed = 0
        self._index_in_epoch = 0

    @property
    def images(self):
        return self._images
    
    @property
    def labels(self):
        return self._labels

    @property
    def num_examples(self):
        return self._num_examples

    @property
    def epochs_completed(self):
        return self._epochs_completed

    def next_batch(self, batch_size, fake_data=False):
        """Return the next `batch_size` examples from this data set."""
        start = self._index_in_epoch
        self._index_in_epoch += batch_size
        if self._index_in_epoch > self._num_examples:
            # Finished epoch
            self._epochs_completed += 1
            # Shuffle the data
            perm = np.arange(self._num_examples)
            np.random.shuffle(perm)
            self._images = self._images[perm]
            self._labels = self._labels[perm]
            # Start next epoch
            start = 0
            self._index_in_epoch = batch_size
            assert batch_size <= self._num_examples
        end = self._index_in_epoch
        return self._images[start:end], self._labels[start:end]


from os import listdir
from os.path import isfile, join
from scipy import misc

max_up = 768 
tr_size = 512
te_size = 128
va_size = 128

def extract_images_labels(folder_name):
    images = [f for f in listdir(folder_name) if isfile(join(folder_name, f)) and f.endswith('png')][:max_up]
    images = np.random.shuffle(images)
    rets = np.zeros((len(images), 512, 512))
    lbs = np.zeros((len(images), 10))
    counter = 0
    for image in images:
        img_data = misc.imread(join(folder_name, image))
        rets[counter][:] = img_data
        vals = np.zeros(10)
        vals[int(image[0])] = 1
        lbs[counter,:] = vals
        counter += 1
    return rets, lbs;

def read_data_sets(train_dir):
    class DataSets(object):
        pass
    
    data_sets = DataSets()
    TRAIN_SIZE = tr_size
    TEST_SIZE = te_size
    VALIDATION_SIZE = max_up - TRAIN_SIZE - TEST_SIZE
    folder = "/home/agah/TF/CSE253Project/spoken_numbers" 
    images, labels = extract_images_labels(folder)

    print("Image Shapes", images.shape)
    train_images = images[:TRAIN_SIZE]
    train_labels = labels[:TRAIN_SIZE]
    test_images = images[TRAIN_SIZE:TRAIN_SIZE+TEST_SIZE]
    test_labels = labels[TRAIN_SIZE:TRAIN_SIZE+TEST_SIZE]
    validation_images = images[TRAIN_SIZE+TEST_SIZE:]
    validation_labels = labels[TRAIN_SIZE+TEST_SIZE:]
    data_sets.train = DataSet(train_images, train_labels)
    data_sets.validation = DataSet(validation_images, validation_labels)
    data_sets.test = DataSet(test_images, test_labels)
    return data_sets



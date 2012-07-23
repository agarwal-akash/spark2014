"""This package provides the basic API to manipulate source code entities
"""

from internal.attributes import lattices
from internal.attributes import lattice_ops
from internal import sets

class Entity:
    """Represents a source code entity on which merges should be done

    This class allows to merge results of entities of a lower level
    (e.g. children) to produce results for entities of a higher
    level. Typically, to merge proof results on the subprogram level to the
    package level, one should do:

        m = Merge()
        pck = m.new_entity("PACKAGE")
        subp = pck.new_input("SUBPROGRAM", maps={"OK" : "PROVED"})

    meaning that the PROVED status at the package level will be deduced from
    the OK status at subprogram level.

    ATTRIBUTES
      states: state domain for this entity
    """

    def __init__(self, merge, name, states=None):
        """Constructor.

        PARAMETERS
            merge:  Merge object to which this entity is attached
            name:   name of the entity
            states: domain of the status attribute
        """
        self.name = name
        self.merge = merge
        self.slocs = self.merge.slocs
        self.object = self.merge.repository.new_object(name)
        if states is not None:
            self.states = states
        else:
            self.states = lattices.PartialOrderAttribute(self.status_name())
        self.object.new_attribute(self.states)
        self.object.join_arrow = None

    def status_name(self):
        return self.name + ".STATUS"

    def new_child(self, name, states, maps):
        """Create a new child entity

        Create an entity whose instances are always included in
        at most one instance of self, inheriting the specified
        properties.

        PARAMETERS
            name: name of the newly created entity
            states: state domain for this child
            maps: map describing how its states maps to its father's states.
                  e.g. {"OK" : "PROVED"} means that OK in the child is proved
                  in the parent.
        """
        child = Entity(self.merge, name, states)
        complete_map = maps
        for value in states.values:
            if not maps.has_key(value):
                complete_map[value] = "UNKNOWN"
        inherits = sets.FilteredArrow(child.states, complete_map)
        child.object.new_arrow(self.name,
                               lattice_ops.Inclusion(lattice=self.slocs,
                                                     object=self.object))
        child.object.new_arrow(self.states.name, inherits)
        if self.object.join_arrow is not None:
            self.object.join_arrow.add(child.object)
        else:
            self.object.join_arrow = lattice_ops.Join(lattice=self.states,
                                                      subobject=child.object,
                                                      in_object_key=self.name)
            self.object.new_arrow(self.states.name,
                                  self.object.join_arrow)

        return child

    def new_input(self, reader, maps):
        child = self.new_child(reader.name, reader.states, maps)
        child.reader = reader
        return child

    def load(self, filename):
        self.reader.load(filename)
        self.object.load(self.reader)

